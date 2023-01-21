import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List todoList = [];

  //reference the box
  final _myBox = Hive.box('myBox');

  //run this method if this is the first time ever opening the app
  void createInitialData() {
    todoList = [
      ["make tutorial", false],
      ["do exercise", false],
    ];
  }

  //load the data from the database
  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  //update the database
  void updateDatabase() {
    _myBox.put("TODOLIST", todoList);
  }
}
