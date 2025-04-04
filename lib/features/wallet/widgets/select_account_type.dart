import 'package:flutter/material.dart';
import 'package:match_maker/core/app_theme.dart';
import 'package:match_maker/core/constants/dimensions.dart';
import 'package:match_maker/features/wallet/widgets/divider.dart';

import 'custom_card1.dart';

class SelectAccountType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      color: AppTheme.white,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(context.borderRadius12), topRight: Radius.circular(context.borderRadius12))
      ),

      child: Padding(
        padding: EdgeInsets.all(context.padding24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Account Type",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: context.space16),
            // CustomDivider(width: double.infinity,
            //  height: 1, gradientList: [AppTheme.darkGold, AppTheme.gradient3]),

             CustomCard1(),

          ],
        ),
      ),
    );
  }
}
