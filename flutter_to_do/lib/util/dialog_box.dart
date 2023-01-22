import 'package:flutter/material.dart';
import 'package:flutter_to_do/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 193, 213, 163),
      content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //get user input
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "add a new task",
                ),
              ),

              //save and cancel buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //save button
                  MyButton(
                    text: "save",
                    onPressed: onSave,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  //cancel button
                  MyButton(
                    text: "cancel",
                    onPressed: onCancel,
                  )
                ],
              ),
            ],
          )),
    );
  }
}
