import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double width;
  final double height;
  final List<Color> gradientList;
  const CustomDivider(
      {super.key,
      required this.width,
      required this.height,
      required this.gradientList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(gradient: LinearGradient(
        begin:Alignment.topLeft ,
        end: Alignment.topRight ,
        colors: gradientList)),
    );
  }
}
