import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Task02 - Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String displayString = '0';
  String numberString = '0';

  double varResult = 0;
  String varOperation;
  bool shouldCalculate = false;

  doCalculate() {
    switch (varOperation) {
      case '+':
        varResult = varResult + double.parse(numberString);
        break;
      case '-':
        varResult = varResult - double.parse(numberString);
        break;
      case '*':
        varResult = varResult * double.parse(numberString);
        break;
      case '/':
        varResult = varResult / double.parse(numberString);
        break;
      default:
        break;
    }

    numberString = varResult.toString();
    displayString = numberString;
  }

  doActionPressButton(String paramTitle) {
    setState(() {
      //print(paramTitle);
      //**** Gak akan proses yang bukan numeric
      if (paramTitle == '+' ||
          paramTitle == '-' ||
          paramTitle == '*' ||
          paramTitle == '/') {
        //*** Non numeric
        if(shouldCalculate) {
          doCalculate();
        }else {
          varResult = double.parse(numberString) ?? 0;
          shouldCalculate = true;
        }

        numberString = '';
        varOperation = paramTitle;
      } else if (paramTitle == '=') {
        doCalculate();
        shouldCalculate = false;
      } else if (paramTitle == 'CE') {
        numberString = '';
        displayString = '0';
        varResult = 0;
        shouldCalculate = true;
      } else {
        //** Menghilangkan leading zero
        if (numberString == '0' || numberString == '0.0') {
          numberString = '';
        }
        //*** Numeric
        numberString += paramTitle;
        displayString = numberString;
      }
    });
  }

  //*** Create Button
  Widget createButton(String varTitle) {
    return Expanded(
      child: ButtonTheme(
        //** Ambil keseluruhan sisa
        height: double.infinity,
        child: OutlineButton(
          onPressed: () {
            doActionPressButton(varTitle);
          },
          child: Text(
            varTitle,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          highlightedBorderColor: Colors.green,
          //*** Set Border
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
    );
  }

  //*** Create Row of Button
  Widget createRow(String title1, String title2, String title3, String title4) {
    return Expanded(
      child: Row(
        children: <Widget>[
          createButton(title1),
          createButton(title2),
          createButton(title3),
          createButton(title4),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //**** 02. ubah jadi padding
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            //**** 01. Expanded buat ambil layar sebanyak sisa yang belum dipakai
            Expanded(
              child: Container(
                color: Color.fromARGB(10, 0, 0, 0),
                //***** 04. Buat Padding
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  //**** 03. Widget align biar bisa align dibawah
                  child: Align(
                    child: Text(
                      displayString,
                      style: TextStyle(
                        fontSize: 80,
                      ),
                    ),
                    alignment: FractionalOffset.bottomRight,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  createRow('+', '-', '*', '/'),
                  createRow('7', '8', '9', '0'),
                  createRow('4', '5', '6', 'CE'),
                  createRow('1', '2', '3', '='),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
