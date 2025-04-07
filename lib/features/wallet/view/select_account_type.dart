import 'package:flutter/material.dart';
import 'package:match_maker/core/app_theme.dart';
import 'package:match_maker/core/constants/dimensions.dart';
import 'package:match_maker/features/wallet/widgets/divider.dart';
import 'package:provider/provider.dart';

import '../view_model/add_account_provider.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/custom_card1.dart';
import 'add_bank_account.dart';

class SelectAccountType extends StatelessWidget {
  const SelectAccountType({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(context.borderRadius12),
              topRight: Radius.circular(context.borderRadius12))),
      child: Padding(
        padding: EdgeInsets.all(context.padding24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Account Type",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: context.space16),
            CustomDivider(
                width: double.infinity,
                height: context.dividerHeight,
                gradientList: [AppTheme.darkGold, AppTheme.gradient3]),
            SizedBox(height: context.space16),
            CustomCard1(
              icon: Icons.smartphone_outlined,
              mainText: "UPI",
              subText: "Add your UPI ID for quick transfers",
            ),
            SizedBox(height: context.space16),
            ChangeNotifierProvider(
              create: (_) => AddAccountProvider(),
              child: GestureDetector(
                onTap: ()
                  {
                    Navigator.of(context).pop();
                    Bottomsheet.showBottom(
                        context: context, content: AddBankAccount());
                  },
                child: CustomCard1(
                  icon: Icons.smartphone_outlined,
                  mainText: "Bank Account",
                  subText: "Add your bank account details",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
