import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';
import 'package:match_maker/features/wallet/widgets/divider.dart';
import 'package:provider/provider.dart';

import '../../../core/app_theme.dart';
import '../view_model/add_account_provider.dart';

class Bottomsheet {
  static Future<bool?> showBottom({
    required String title,
    required BuildContext context,
    required Widget content,
    VoidCallback? onDismissed,
    required bool isAddBankAccount,
  }) async {
    final provider = Provider.of<AccountProvider>(context, listen: false);
    final result = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(context.borderRadius12)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              left: context.space8, right: context.space8, top: 100),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(context.borderRadius12),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(context.padding24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Wrap(
                      runSpacing: context.space8,
                      alignment: WrapAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            isAddBankAccount
                                ? provider.clearControllers()
                                : null;
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: AppTheme.darkGold,
                            weight: 35,
                          ),
                        ),
                        SizedBox(
                          width: context.space12,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              color: AppTheme.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: context.space16),
                    CustomDivider(
                        width: double.infinity,
                        height: context.dividerHeight,
                        gradientList: [AppTheme.darkGold, AppTheme.gradient3]),
                    SizedBox(height: context.space16),
                    content,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).whenComplete(() => onDismissed?.call());

    return result;
  }
}
