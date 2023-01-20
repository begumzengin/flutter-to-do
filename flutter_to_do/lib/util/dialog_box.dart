import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
          height: 120,
          child: Column(
            children: [
              //get user input
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "add a new task",
                ),
              ),

              //save and cancel buttons
              Row(
                children: [],
              ),
            ],
          )),
    );
  }
}
