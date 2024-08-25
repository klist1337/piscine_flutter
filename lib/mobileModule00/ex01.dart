import 'package:flutter/material.dart';

class ChangeText extends StatefulWidget {
  const ChangeText({super.key});

  @override
  State<ChangeText> createState() => _ChangeTextState();
}

class _ChangeTextState extends State<ChangeText> {
List<String> texts = ["A simple text", "Hello World"];

String text = "A simple text";
bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 78, 113, 2),
                border: Border.all(color: const Color.fromARGB(255, 111, 161, 2)),
                borderRadius: BorderRadius.circular(8)
              ),
              child:  Text(text, 
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                //backgroundColor: Color.fromARGB(255, 34, 112, 0)
              ),),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isPressed =! isPressed;
                  if (isPressed == true) {
                    text = texts[1];
                  }
                  else {
                    text = texts[0];
                  }
                });
              }, 
              child: const Text("click me"))
          ],
        ),
      ),
    );
  }
}