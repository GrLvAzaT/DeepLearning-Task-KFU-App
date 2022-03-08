import 'package:design1/constants/app_constants.dart';
import 'package:design1/widgets/center_bar.dart';
import 'package:flutter/material.dart';
import 'package:design1/widgets/left_bar.dart';
import 'package:design1/widgets/right_bar.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  var _designResult = [];
  String _restResult = "";

  /////
  String w1 = '';
  String w2 = '';
  String x1 = '';
  String e1 = '';
  //////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Персептрон",
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
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  int length = int.parse(_heightController.text);
                  int needValue = int.parse(_weightController.text);
                  setState(() {
                    var x = List.filled(length, 0);
                    var w = List.filled(length, 0);

                    int u = 0;
                    int y;
                    int d = needValue;
                    int count = 0;

                    var _random = Random();
                    x1 = '';
                    for (int i = 0; i < x.length; i++) {
                      int rnd = _random.nextInt(20) - 10;
                      x[i] = rnd;

                      ///////x
                      String e1 = x[i].toString();
                      x1 = x1 + e1 + '\n';
                    }
                    w1 = '';
                    for (int i = 0; i < length; i++) {
                      int rndw = _random.nextInt(200) - 100;
                      w[i] = rndw;

                      ///////w
                      String e1 = w[i].toString();
                      w1 = w1 + e1 + '\n';
                    }

                    for (int i = 0; i < length; i++) {
                      u += (x[i] * w[i]);
                    }

                    if (u >= 0) {
                      y = 1;
                    } else {
                      y = 0;
                    }

                    while (y != d) {
                      u = 0;
                      for (int i = 0; i < length; i++) {
                        if (y == 0) {
                          w[i] += x[i];
                        } else {
                          w[i] -= x[i];
                        }
                        u += (x[i] * w[i]);
                      }
                      if (u >= 0) {
                        y = 1;
                      } else {
                        y = 0;
                      }
                      count++;
                    }

                    _restResult = "Количество итераций: $count";
                    _designResult = w;
                    w2 = '';
                    for (int i = 0; i < length; i++) {
                      e1 = w[i].toString();
                      w2 = w2 + e1 + '\n';
                    }
                  });
                },
                child: Container(
                  child: Text(
                    "Подобрать",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: redHexColor,
                    ),
                  ),
                ),
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
              ////////////////////-----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //CenterBar(barWidth: 50),
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
                  'Перейти ко 2 лабораторной',
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
