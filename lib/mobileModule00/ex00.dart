import 'package:flutter/material.dart';

class SimpleText extends StatelessWidget {
  const SimpleText({super.key});

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
              child: const Text('A  simple text', 
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                //backgroundColor: Color.fromARGB(255, 34, 112, 0)
              ),),
            ),
            ElevatedButton(onPressed: () {
              print('Button pressed');
            }, child: const Text("click me"))
          ],
        ),
      ),
    );
  }
}