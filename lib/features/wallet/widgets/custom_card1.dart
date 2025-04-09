import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';

import '../../../core/app_theme.dart';

class CustomCard1 extends StatelessWidget {
  final String mainText;
  final String subText;
  final IconData icon;
  const CustomCard1(
      {super.key,
      required this.icon,
      required this.mainText,
      required this.subText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(context.borderRadius8)),
        color: AppTheme.white,
        gradient: LinearGradient(
          colors: [AppTheme.darkGold, AppTheme.gradient3],
          end: Alignment.centerLeft,
          begin: Alignment.centerRight,
        ),
      ),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(context.dividerHeight1),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(context.borderRadius8)),
          color: AppTheme.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.padding14, vertical: context.padding18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: AppTheme.darkGold,
                weight: 1,
              ),
              SizedBox(
                width: context.space8,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mainText,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                          fontSize: context.font16,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      subText,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                          fontSize: context.font14,
                          fontWeight: FontWeight.w300,
                          color: AppTheme.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: context.space8,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: AppTheme.darkGold,
                weight: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
