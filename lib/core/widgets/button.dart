import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';

import '../app_theme.dart';

class CustomButton extends StatelessWidget {
  final Widget content;
  final VoidCallback onTap;
  const CustomButton({super.key, required this.onTap, required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: context.buttonHeight,
        decoration: BoxDecoration(
            color: AppTheme.darkGold,
            borderRadius:
                BorderRadius.all(Radius.circular(context.borderRadius8))),
        child: Center(
          child: content,
        ),
      ),
    );
  }
}