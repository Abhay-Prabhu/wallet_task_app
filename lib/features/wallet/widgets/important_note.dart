import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';

import '../../../core/app_theme.dart';

class ImportantNote extends StatelessWidget {
  const ImportantNote({super.key});

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18,
                    color: AppTheme.darkGold,
                    weight: 15,
                  ),
                  SizedBox(
                    width: context.space4,
                  ),
                  Text(
                    "Important",
                    style: TextStyle(
                        fontSize: context.font14,
                        color: AppTheme.black,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: context.space8,
              ),
              Text(
                "Please ensure all details are correct. These details will be used for transferring payments and rewards to your account",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: context.font14,
                    color: AppTheme.grey,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
