import 'package:flutter/material.dart';

import '../app_theme.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const CustomCircularProgressIndicator(
      {super.key, required this.height, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: CircularProgressIndicator(
          color: AppTheme.grey,
        ),
      ),
    );
  }
}
