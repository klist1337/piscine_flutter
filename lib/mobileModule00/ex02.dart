import 'package:flutter/material.dart';

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {

  List<String> buttons = ["7", "8", "9", "C", "AC", 
  "4", "5", "6", "+", "-", "1", "2", "3", "x", "/", "0", ".", "00", "=", " "];
  List<String> otherButtons = ["C", "AC"];
  List<String> operators = ["+", "-", "x", "/", "="];


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
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('0', style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color:  Color(0xFF607d8b)
                ),),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('0', style: TextStyle(
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
                  print("button pressed:${buttons[index]}");
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
}