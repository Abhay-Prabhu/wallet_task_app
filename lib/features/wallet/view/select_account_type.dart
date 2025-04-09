import 'package:flutter/material.dart';
import 'package:match_maker/core/app_theme.dart';
import 'package:match_maker/core/constants/dimensions.dart';
import 'package:match_maker/features/wallet/view_model/redeem_detail_provider.dart';
import 'package:provider/provider.dart';
import '../view_model/add_account_provider.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/custom_card1.dart';
import 'add_edit_bank_account.dart';

class SelectAccountType extends StatefulWidget {
  const SelectAccountType({
    super.key,
  });

  @override
  State<SelectAccountType> createState() => _SelectAccountTypeState();
}

class _SelectAccountTypeState extends State<SelectAccountType> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RedeemDetailsProvider>(context, listen: false)
          .fetchRedeemDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    final redeemProvider = Provider.of<RedeemDetailsProvider>(context);
    print(
        "print from select account - bank - ${redeemProvider.isBankAccountNull}, upi - ${redeemProvider.isBankUpiNull}, ");

    return Container(
      decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(context.borderRadius12),
              topRight: Radius.circular(context.borderRadius12))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (redeemProvider.isBankUpiNull) ...[
            CustomCard1(
              icon: Icons.smartphone_outlined,
              mainText: "UPI",
              subText: "Add your UPI ID for quick transfers",
            ),
          ],
          if (redeemProvider.isBankAccountNull) ...[
            SizedBox(height: context.space16),
            ChangeNotifierProvider(
              create: (_) => AccountProvider(),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Bottomsheet.showBottom(
                      title: "Add Bank Account",
                      context: context,
                      content: AddEditBankAccount(
                        isEditMode: false,
                      ));
                },
                child: CustomCard1(
                  icon: Icons.smartphone_outlined,
                  mainText: "Bank Account",
                  subText: "Add your bank account details",
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
