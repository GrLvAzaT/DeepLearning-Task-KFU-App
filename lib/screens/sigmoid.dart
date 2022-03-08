import 'package:design1/constants/app_constants.dart';
import 'package:design1/screens/gg.dart';
import 'package:design1/widgets/center_bar.dart';
import 'package:flutter/material.dart';
import 'package:design1/widgets/left_bar.dart';
import 'package:design1/widgets/right_bar.dart';
import 'dart:math';
//import 'package:dart_numerics/dart_numerics.dart' as numerics;

class SigmoidScreen extends StatefulWidget {
  @override
  _SigmoidScreenState createState() => _SigmoidScreenState();
}

class _SigmoidScreenState extends State<SigmoidScreen> {
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _inaccuracyController = TextEditingController();

  TextEditingController _heightController2 = TextEditingController();
  TextEditingController _weightController2 = TextEditingController();
  TextEditingController _inaccuracyController2 = TextEditingController();
  var _designResult = [];
  String _restResult = "";

  var _designResult1 = [];
  String _restResult1 = "";

  /////
  String w1 = '';
  String w2 = '';
  String x1 = '';
  String e1 = '';
  //////
  String w11 = '';
  String w22 = '';
  String x11 = '';
  String e11 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Сигмоидальный нейрон",
              style: TextStyle(
                  color: redHexColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 32)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: mainHexColor,
        //resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text("Униполярная функция:\n ",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                      color: redHexColor,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.wavy,
                      decorationThickness: 1)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    child: TextField(
                      controller: _heightController,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          color: redHexColor),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Размерность матрицы",
                          hintStyle: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withOpacity(.8))),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: TextField(
                      controller: _weightController,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w300,
                          color: redHexColor),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Желаемое значение",
                          hintStyle: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withOpacity(.8))),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: TextField(
                      controller: _inaccuracyController,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w300,
                          color: redHexColor),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Погрешность",
                          hintStyle: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withOpacity(.8))),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //-----------------------------------

                  //-----------------------------------
                  GestureDetector(
                    onTap: () {
                      int length = int.parse(_heightController.text);
                      double needValue = double.parse(_weightController.text);
                      double inac = double.parse(_inaccuracyController.text);
                      setState(() {
                        var x = List<double>.filled(length, 0);
                        var weight = List<double>.filled(length, 0);
                        double u = 0;
                        double y;
                        int count = 0;
                        Random random = new Random();

                        x1 = '';
                        for (int i = 0; i < length; i++) {
                          int rnd = Random().nextInt(200);
                          x[i] = rnd / 100;

                          ///////x
                          String e1 = x[i].toString();
                          x1 = x1 + e1 + '\n';
                        }

                        w1 = '';
                        for (int i = 0; i < length; i++) {
                          int rnd = -100 + Random().nextInt(200);
                          weight[i] = rnd / 100;
                          ///////weight
                          String e1 = weight[i].toString();
                          w1 = w1 + e1 + '\n';
                        }

                        for (int i = 0; i < length; i++) {
                          u += (x[i] * weight[i]);
                        }

                        y = 1 / (1 + (pow(e, -u * 0.5)));

                        double e1 = y - needValue;

                        while (inac <= e1.abs()) {
                          var derived = y * (1 - (y)) * 0.5;
                          var delta = List<double>.filled(length, 0);

                          for (int i = 0; i < length; i++) {
                            delta[i] = x[i] * e1 * derived;
                            weight[i] = weight[i] - delta[i];
                          }

                          u = 0;
                          for (int i = 0; i < length; i++) {
                            u += (x[i] * weight[i]);
                          }
                          y = 1 / (1 + (pow(e, -u * 0.5)));
                          count++;
                          e1 = y - needValue;
                        }

                        _restResult = "Количество итераций: $count";
                        _designResult = weight;

                        w2 = '';
                        for (int i = 0; i < length; i++) {
                          ///////weight
                          String e1 = weight[i].toString();
                          w2 = w2 + e1 + '\n';
                        }
                      });
                    },
                    child: Container(
                      child: Text(
                        "Наискорейший спуск",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: redHexColor,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      int length = int.parse(_heightController.text);
                      double needValue = double.parse(_weightController.text);
                      double inac = double.parse(_inaccuracyController.text);
                      setState(() {
                        var x = List<double>.filled(length, 0);
                        var weight = List<double>.filled(length, 0);
                        double u = 0;
                        double y;
                        int count = 0;
                        Random random = new Random();

                        x1 = '';
                        for (int i = 0; i < length; i++) {
                          int rnd = -100 + Random().nextInt(200);
                          x[i] = rnd / 100;

                          ///////x
                          String e1 = x[i].toString();
                          x1 = x1 + e1 + '\n';
                        }

                        w1 = '';
                        for (int i = 0; i < length; i++) {
                          int rnd = -100 + Random().nextInt(200);
                          weight[i] = rnd / 100;
                          ///////weight
                          String e1 = weight[i].toString();
                          w1 = w1 + e1 + '\n';
                        }

                        for (int i = 0; i < length; i++) {
                          u += (x[i] * weight[i]);
                        }

                        y = 1 / (1 + (pow(e, -u * 0.5)));

                        double e1 = y - needValue;

                        while (inac <= e1.abs()) {
                          var derived = y * (1 - (y)) * 0.5;
                          var delta = List<double>.filled(length, 0);

                          for (int i = 0; i < length; i++) {
                            delta[i] = x[i] * e1;
                            weight[i] -= delta[i];
                          }

                          u = 0;
                          for (int i = 0; i < length; i++) {
                            u += (x[i] * weight[i]);
                          }
                          y = 1 / (1 + (pow(e, -u * 0.5)));
                          count++;
                          e1 = y - needValue;
                        }

                        _restResult = "Количество итераций: $count";
                        _designResult = weight;

                        w2 = '';
                        for (int i = 0; i < length; i++) {
                          ///////weight
                          String e1 = weight[i].toString();
                          w2 = w2 + e1 + '\n';
                        }
                      });
                    },
                    child: Container(
                      child: Text(
                        "Дискретный метод",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: redHexColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 70,
                        child: Text(
                          'X:',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              color: redHexColor),
                        ),
                      ),
                      Container(
                        width: 150,
                        child: Text(
                          'W1:',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              color: redHexColor),
                        ),
                      ),
                      Container(
                        width: 90,
                        child: Text(
                          'W2:',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              color: redHexColor),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      height: 400.0,
                      width: 350.0,

                      //padding: EdgeInsets.all(20.0),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // ListView.separated(
                                  //   separatorBuilder:
                                  //       (BuildContext context, int index) =>
                                  //           VerticalDivider(),
                                  //   shrinkWrap: true,
                                  //   itemCount: _designResult.length,
                                  //   itemBuilder: (context, index) {
                                  //     return ListTile(
                                  //         title: Text(
                                  //       '${_designResult[index]}',
                                  //       style: TextStyle(
                                  //           fontSize: 32,
                                  //           //fontWeight: FontWeight.w400,
                                  //           color: redHexColor),
                                  //     ));
                                  //   },
                                  // ),
                                  Text(x1,
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w400,
                                          color: redHexColor))
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(w1,
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w400,
                                          color: redHexColor))
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(w2,
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w400,
                                          color: redHexColor))
                                ]),
                          ]))
                ],
              ),
              Visibility(
                //количество итераций
                visible: _restResult.isNotEmpty,
                child: Container(
                  child: Text(_restResult,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: redHexColor)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Биполярная функция:\n ",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                      color: redHexColor,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.wavy,
                      decorationThickness: 1)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    child: TextField(
                      controller: _heightController2,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          color: redHexColor),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Размерность матрицы",
                          hintStyle: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withOpacity(.8))),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: TextField(
                      controller: _weightController2,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w300,
                          color: redHexColor),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Желаемое значение",
                          hintStyle: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withOpacity(.8))),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: TextField(
                      controller: _inaccuracyController2,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w300,
                          color: redHexColor),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Погрешность",
                          hintStyle: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withOpacity(.8))),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      int length = int.parse(_heightController.text);
                      int needValue = int.parse(_weightController.text);
                      double inac = double.parse(_inaccuracyController.text);
                      setState(() {
                        var x = List<double>.filled(length, 0);
                        var weight = List<double>.filled(length, 0);
                        double u = 0;
                        double y;
                        int count = 0;
                        Random random = Random();

                        x11 = '';
                        for (int i = 0; i < length; i++) {
                          int rnd = -100 + Random().nextInt(200);
                          x[i] = rnd.toDouble() / 100;

                          ///////x
                          String e11 = x[i].toString();
                          x11 = x11 + e11 + '\n';
                        }

                        w11 = '';
                        for (int i = 0; i < length; i++) {
                          int rnd = -100 + Random().nextInt(200);
                          weight[i] = rnd.toDouble() / 100;
                          ///////weight
                          String e11 = weight[i].toString();
                          w11 = w11 + e11 + '\n';
                        }

                        for (int i = 0; i < length; i++) {
                          u += (x[i] * weight[i]);
                        }

                        y = tanh(0.5 * u);

                        double e1 = y - needValue;

                        while (inac <= e1.abs()) {
                          var derived = 0.5 * (1 - pow(y, 2));
                          var delta = List<double>.filled(length, 0);

                          for (int i = 0; i < length; i++) {
                            delta[i] = x[i] * e1 * derived;
                            weight[i] -= -delta[i];
                          }

                          u = 0;
                          for (int i = 0; i < length; i++) {
                            u += (x[i] * weight[i]);
                          }
                          y = tanh(0.5 * u);

                          count++;
                          e1 = y - needValue;
                        }

                        _restResult1 = "Количество итераций: $count";
                        _designResult = weight;
                        w22 = '';
                        for (int i = 0; i < length; i++) {
                          String e1 = weight[i].toString();
                          w22 = w22 + e1 + '\n';
                        }
                      });
                    },
                    child: Container(
                      child: Text(
                        "Наискорейший спуск",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: redHexColor,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      int length = int.parse(_heightController2.text);
                      int needValue = int.parse(_weightController2.text);
                      double inac = double.parse(_inaccuracyController2.text);
                      setState(() {
                        var x = List<double>.filled(length, 0);
                        var weight = List<double>.filled(length, 0);
                        double u = 0;
                        double y;
                        int count = 0;
                        Random random = Random();

                        x11 = '';
                        for (int i = 0; i < length; i++) {
                          int rnd = -100 + Random().nextInt(200);
                          x[i] = rnd.toDouble() / 100;

                          ///////x
                          String e11 = x[i].toString();
                          x11 = x11 + e11 + '\n';
                        }

                        w11 = '';
                        for (int i = 0; i < length; i++) {
                          int rnd = -100 + Random().nextInt(200);
                          weight[i] = rnd.toDouble() / 100;
                          ///////weight
                          String e11 = weight[i].toString();
                          w11 = w11 + e11 + '\n';
                        }

                        for (int i = 0; i < length; i++) {
                          u += (x[i] * weight[i]);
                        }

                        y = tanh(0.5 * u);

                        double e1 = y - needValue;

                        while (inac <= e1.abs()) {
                          var derived = 0.5 * (1 - pow(y, 2));
                          var delta = List<double>.filled(length, 0);

                          for (int i = 0; i < length; i++) {
                            delta[i] = x[i] * e1;
                            weight[i] -= delta[i];
                          }

                          u = 0;
                          for (int i = 0; i < length; i++) {
                            u += (x[i] * weight[i]);
                          }
                          y = tanh(0.5 * u);

                          count++;
                          e1 = y - needValue;
                        }

                        _restResult1 = "Количество итераций: $count";
                        _designResult = weight;
                        w22 = '';
                        for (int i = 0; i < length; i++) {
                          String e1 = weight[i].toString();
                          w22 = w22 + e1 + '\n';
                        }
                      });
                    },
                    child: Container(
                      child: Text(
                        "Дискретный метод",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: redHexColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 70,
                        child: Text(
                          'X:',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              color: redHexColor),
                        ),
                      ),
                      Container(
                        width: 150,
                        child: Text(
                          'W1:',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              color: redHexColor),
                        ),
                      ),
                      Container(
                        width: 90,
                        child: Text(
                          'W2:',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              color: redHexColor),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      height: 400.0,
                      width: 350.0,

                      //padding: EdgeInsets.all(20.0),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(x11,
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w400,
                                          color: redHexColor))
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(w11,
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w400,
                                          color: redHexColor))
                                ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(w22,
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w400,
                                          color: redHexColor))
                                ]),
                          ]))
                ],
              ),
              Visibility(
                //количество итераций
                visible: _restResult1.isNotEmpty,
                child: Container(
                  child: Text(_restResult1,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: redHexColor)),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LeftBar(
                    barWidth: 40,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              LeftBar(
                barWidth: 70,
              ),
              SizedBox(
                height: 20,
              ),
              LeftBar(
                barWidth: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  textAlign:
                  TextAlign.center;
                  Navigator.pushReplacementNamed(context, '/sigmoid');
                },
                child: Text(
                  'Перейти к 3 лабораторной',
                ),
                style: ButtonStyle(
                    alignment: Alignment.center,
                    backgroundColor: MaterialStateProperty.all(redHexColor),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(30)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 25))),
              ),
              SizedBox(
                height: 20,
              ),
              RightBar(barWidth: 70),
              SizedBox(
                height: 20,
              ),
              RightBar(barWidth: 70)
            ],
          ),
        ));
  }
}

double tanh(double angle) {
  if (angle > 19.1) {
    return 1.0;
  }

  if (angle < -19.1) {
    return -1.0;
  }

  var e1 = exp(angle);
  var e2 = exp(-angle);
  return (e1 - e2) / (e1 + e2);
}
