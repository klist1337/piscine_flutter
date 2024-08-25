import 'package:flutter/material.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {

  List<String> buttons = ["7", "8", "9", "C", "AC", "4", "5", "6", "+", "-"];
  List<String> otherButtons = ["C", "AC"];
  List<String> operators = ["+", "-"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 44, 63),
      appBar: AppBar(
        title: const Text('Calculator', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 29, 80, 101),
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('0', style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 29, 80, 101)
                ),),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.3,),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5), 
              itemCount: buttons.length,
              itemBuilder: (context, index) {
              return TextButton (onPressed: () {
                print("Button pressed: ${buttons[index]}");
              }, child: Builder(
                builder: (context) {
                  if (otherButtons.contains(buttons[index])) {
                     return Text(buttons[index], 
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red
                      ),);
                    }
                    if (operators.contains(buttons[index])) {
                      return Text(buttons[index], 
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),);
                    }
                    else {
                      return Text(buttons[index], 
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black
                        ),);
                    }
                 
                }
              ));
              
            }),
          ),
        ],
      ),
    );
  }
}