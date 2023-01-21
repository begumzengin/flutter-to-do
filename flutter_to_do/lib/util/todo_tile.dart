import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  Color getRandomColor() {
    var colors = [
      Color.fromARGB(255, 245, 182, 210),
      Color.fromARGB(255, 207, 227, 243),
      Color.fromARGB(255, 192, 212, 241),
      Color.fromARGB(255, 244, 172, 208),
      Color.fromARGB(255, 235, 180, 216),
      Color.fromARGB(255, 188, 217, 239),
      Color.fromARGB(255, 172, 203, 231),
      Color.fromARGB(255, 245, 193, 219),
      Color.fromARGB(255, 245, 174, 207),
      Color.fromARGB(255, 213, 225, 239),
    ];
    var random = new Random();
    var index = random.nextInt(colors.length);
    return colors[index];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.black,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              //checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),

              //task name
              Text(taskName,
                  style: TextStyle(
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none)),
            ],
          ),
          decoration: BoxDecoration(
            color: getRandomColor(),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
