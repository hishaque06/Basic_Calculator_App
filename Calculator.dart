import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
      color: Colors.white,
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  // Variables
  dynamic display = '0';

  // Widget For Calculator Buttons
  Widget myButton(String buttonName, Color buttonColour) {
    return Material(
      color: buttonColour,
      borderRadius: BorderRadius.circular(70),
      child: InkWell(
        onTap: () {
          setState(() {
            // Calculator Logic
            if (buttonName != "AC" &&
                buttonName != "Del" &&
                buttonName != "=") {
              if (display == "0") {
                display = buttonName;
              } else {
                display += buttonName;
              }
              // All Clear And Backspace Buttons
            } else if (buttonName == "AC") {
              display = "0";
            } else if (buttonName == "Del" && display != "0") {
              display = display.substring(0, display.length - 1);
            }
              // Equals Button
              else if (buttonName == "=") {
              Parser p = Parser();
              Expression exp = p.parse(display);
              ContextModel cm = ContextModel();
              num result = exp.evaluate(EvaluationType.REAL, cm);
              if (result.toInt() == result) {
                result = result.toInt();
              }
              display = result.toString();
            }
          });
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 75,
          width: 60,
          child: Center(
            child: Text(
              buttonName,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ),
    );
  }

  //Calculator
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculator",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          toolbarHeight: 25,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Display Screen
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '$display',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 85,
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                  ],
                ),
              ),

              // Keypad
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myButton("+", Colors.blue.shade400),
                  myButton("-", Colors.blue.shade400),
                  myButton("AC", Colors.blue.shade400)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myButton("*", Colors.blue.shade400),
                  myButton("/", Colors.blue.shade400),
                  myButton("Del", Colors.blue.shade400)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myButton("7", Colors.blue.shade200),
                  myButton("8", Colors.blue.shade200),
                  myButton("9", Colors.blue.shade200)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myButton("4", Colors.blue.shade200),
                  myButton("5", Colors.blue.shade200),
                  myButton("6", Colors.blue.shade200)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myButton("1", Colors.blue.shade200),
                  myButton("2", Colors.blue.shade200),
                  myButton("3", Colors.blue.shade200)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myButton(".", Colors.blue.shade200),
                  myButton("0", Colors.blue.shade200),
                  myButton("=", Colors.blue.shade900)
                ],
              )
            ],
          ),
        ));
  }
}
