import 'package:flutter/material.dart';
import 'package:design1/constants/app_constants.dart';

class CenterBar extends StatelessWidget {
  final double barWidth;

  const CenterBar({Key? key, required this.barWidth}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        height: 50,
        width: barWidth,
        decoration: BoxDecoration(color: redHexColor),
      )
    ]);
  }
}
