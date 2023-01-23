import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do/data/database.dart';
import 'package:flutter_to_do/util/dialog_box.dart';
import 'package:flutter_to_do/util/todo_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the hive box
  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();

  //confetti
  final _confettiControl = ConfettiController(duration: Duration(seconds: 2));
  bool isPlaying = false;

  @override
  void dispose() {
    super.dispose();
    _confettiControl.dispose();
  }

  @override
  void initState() {
    //if this is the first time ever opening the app
    //create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //there already exists data
      db.loadData();
    }

    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
    _confettiControl.play();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  //create a new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 221, 188),
      appBar: AppBar(
        title: Text('to do',
            style: GoogleFonts.sora(
                letterSpacing: 4,
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 66, 88, 70))),
        elevation: 1,
        backgroundColor: Color(0xFFEED059),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFEED059),
      ),
      body: Stack(alignment: Alignment.topCenter, children: [
        ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.todoList[index][0],
              taskCompleted: db.todoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ),
        ConfettiWidget(
          confettiController: _confettiControl,
          blastDirection: pi / 2,
          colors: [
            Color.fromARGB(255, 193, 199, 206),
            Color.fromARGB(255, 130, 172, 179),
            Color.fromARGB(255, 245, 157, 0),
            Color.fromARGB(255, 0, 92, 80),
            Color.fromARGB(255, 7, 36, 28),
          ],
          gravity: 0.2,
          emissionFrequency: 0.08,
          shouldLoop: false,
        )
      ]),
    );
  }
}
