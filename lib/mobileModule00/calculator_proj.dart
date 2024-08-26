import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorProj extends StatefulWidget {
  const CalculatorProj({super.key});

  @override
  State<CalculatorProj> createState() => _CalculatorProjState();
}

class _CalculatorProjState extends State<CalculatorProj> {

  List<String> buttons = ["7", "8", "9", "C", "AC", 
  "4", "5", "6", "+", "-", "1", "2", "3", "x", "/", "0", ".", "00", "=", " "];
  List<String> otherButtons = ["C", "AC"];
  List<String> operators = ["+", "-", "x", "/", "="];
  String userInput = "";
  bool isTaped = false;
  String answer = "";
  bool isEqualPressed = false; 
  @override
  Widget build(BuildContext context) {
      bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: const Color(0xFF37474F),
      appBar: AppBar(
        title: const Text('Calculator', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: const Color(0xFF607d8b)
      ),
      body: Column(
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: isTaped ?
                Text(userInput, style: const TextStyle(
                  fontSize: 24,
                  fontWeight:  FontWeight.bold,
                  color:   Color(0xFF607d8b)
                ),) : 
                 const Text("0", style:  TextStyle(
                  fontSize: 24,
                  fontWeight:  FontWeight.bold,
                  color:   Color(0xFF607d8b)
                ),)
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: isEqualPressed ?
                Text(answer, style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color:  Color(0xFF607d8b)
                ),) :
                const Text('0', style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color:  Color(0xFF607d8b)
                ),),
              ),
            ],
          ),
          SizedBox(height: isPortrait ? 
          MediaQuery.of(context).size.height * 0.4 : MediaQuery.of(context).size.height * 0.086),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,
              childAspectRatio: isPortrait ? 1 : 4),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (!otherButtons.contains(buttons[index]) && buttons[index] != "=") {
                    setState(() {
                    isTaped = true;
                    userInput += buttons[index];
                  });
                  }
                   if (buttons[index] == "AC") {
                    //reinitialise le user input
                    setState(() {
                      userInput = "";
                      isTaped = false;
                      isEqualPressed = false;
                    });
                  }
                   else if (buttons[index] == "C") {
                    // supprime le dernier input taper
                      if (userInput.length > 1) {
                        setState(() {
                          userInput = userInput.substring(0, userInput.length - 1);
                        });
                      }
                      else if (userInput.length == 1) {
                        setState(() {
                          userInput = "";
                          isTaped = false;
                        });
                      }
                  }
                  if (buttons[index] == "=") {
                    if (userInput.isNotEmpty) {
                      equalPressed();
                    }
                  }
                  
                },
                child: Container(
                decoration: const BoxDecoration(
                  color:  Color(0xFF607d8b),
                ),
                child: Center(
                  child: Builder(
                    builder: (context) {
                      if (otherButtons.contains(buttons[index])) {
                         return Text(buttons[index], 
                          style: const TextStyle(
                            fontSize: 18,
                            color:  Color(0xFFA52F32),
                            fontWeight: FontWeight.bold

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
                  ),
                )),
              );
              
            }),
          ),
        ],
      ),
    );
  }
  void equalPressed() {
    isEqualPressed = true;
    String finalUserInput = userInput.replaceAll(RegExp(r'x'), '*');
    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      answer = eval.toString();
    });
  }
}