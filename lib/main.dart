// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors, deprecated_member_use, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = '0';
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "Back") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget BuildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.5),
            side: BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid)),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      BuildButton("C", 1, Colors.deepOrange),
                      BuildButton("Back", 1, Colors.deepOrange),
                      BuildButton("÷", 1, Colors.deepOrange),
                    ]),
                    TableRow(children: [
                      BuildButton("7", 1, Colors.black54),
                      BuildButton("8", 1, Colors.black54),
                      BuildButton("9", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      BuildButton("4", 1, Colors.black54),
                      BuildButton("5", 1, Colors.black54),
                      BuildButton("6", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      BuildButton("1", 1, Colors.black54),
                      BuildButton("2", 1, Colors.black54),
                      BuildButton("3", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      BuildButton(".", 1, Colors.black54),
                      BuildButton("0", 1, Colors.black54),
                      BuildButton("00", 1, Colors.black54),
                    ])
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(children: [
                  TableRow(children: [
                    BuildButton("×", 1, Colors.deepOrange),
                  ]),
                  TableRow(children: [
                    BuildButton("+", 1, Colors.deepOrange),
                  ]),
                  TableRow(children: [
                    BuildButton("-", 1, Colors.deepOrangeAccent),
                  ]),
                  TableRow(children: [
                    BuildButton("=", 2, Colors.deepOrange),
                  ]),
                ]),
              )
            ],
          )
        ],
      ),
    );
  }
}
