import 'package:flutter/material.dart';

import '../../../core/app_theme.dart';

class CustomCard1 extends StatelessWidget {
  const CustomCard1({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppTheme.white,
              gradient: LinearGradient(
                colors: [AppTheme.darkGold, AppTheme.gradient3],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
              border: Border(left: BorderSide())),
               padding: EdgeInsets.all(2), 
        ),
        Container(
          margin: EdgeInsets.all(16),
           padding: const EdgeInsets.all(16),
          // height: 45,
          color: AppTheme.white,)
      ],
    );
  }
}
