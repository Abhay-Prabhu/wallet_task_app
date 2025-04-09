import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';
import 'package:match_maker/core/widgets/button.dart';
import 'package:match_maker/core/widgets/circular_progress_indicator.dart';
import 'package:match_maker/features/wallet/view/add_edit_bank_account.dart';
import 'package:match_maker/features/wallet/view_model/add_account_provider.dart';
import 'package:match_maker/features/wallet/view_model/redeem_detail_provider.dart';
import 'package:match_maker/features/wallet/view_model/check_balance_provider.dart';
import 'package:match_maker/features/wallet/view/select_account_type.dart';
import 'package:match_maker/features/wallet/widgets/wallet_display_card.dart';
import 'package:provider/provider.dart';
import '../../../core/app_theme.dart';
import '../../../core/utils/enum.dart';
import '../../../core/widgets/custom_dialog_box.dart';
import '../../../core/widgets/custom_toast.dart';
import '../widgets/bottom_sheet.dart';
import 'base_wallet_page.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<RedeemDetailsProvider>(context, listen: false)
          .fetchRedeemDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Provider.of<CheckBalance>(context, listen: false).checkBalance();
    });

    return BaseWalletPage(
      content: Padding(
        padding: EdgeInsets.all(context.padding24),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your accounts",
                style: TextStyle(
                  fontFamily: 'MonsterArt',
                  fontSize: context.font16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: context.space12),
              Text(
                "You can add up to 2 accounts",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: context.font16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.grey,
                ),
              ),
              SizedBox(height: context.space12),

              // *** Redeem Details Consumer ***
              Consumer<RedeemDetailsProvider>(
                  builder: (context, provider, child) {
                if (provider.state == ViewState.loading) {
                  return Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomCircularProgressIndicator(
                          color: AppTheme.grey,
                          height: context.space32,
                          width: context.space32,
                        )),
                  );
                } else if (provider.state == ViewState.error) {
                  return Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Something went wrong, Please try again...",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: context.font16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.grey,
                        ),
                      ),
                    ),
                  );
                } else if (provider.redeemDetails?.data == null ||
                    provider.redeemDetails!.data!.isEmpty ||
                    !provider.redeemDetails!.data!
                        .any((account) => account.bankAccountDetails != null)) {
                  print("in no payment section");
                  return Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "No payment accounts available",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: context.font16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.grey,
                        ),
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.redeemDetails?.data?.length,
                    itemBuilder: (context, index) {
                      print("in data display section");
                      final account = provider.redeemDetails?.data?[index];
                      final upiString =
                          account?.bankAccountDetails?.bankAccountNumber ?? '';
                      String maskedUPI = upiString.length > 5
                          ? '* ' * (upiString.length - 5) +
                              upiString.substring(upiString.length - 5)
                          : upiString;

                      return WalletDisplayCard(
                        label: "Bank Account",
                        value: maskedUPI,
                        onComplete: () async {
                          if (!context.mounted) return;
                          await provider.fetchRedeemDetails();
                        },
                        onEdit: () async {
                          final res = await Bottomsheet.showBottom(
                              title: "Edit Redeem Payment",
                              context: context,
                              content: AddEditBankAccount(
                                bankAccountmodel: provider.redeemDetails!
                                    .data?[index].bankAccountDetails,
                                isEditMode: true,
                              ));

                          if (res != null) {
                            await provider.fetchRedeemDetails();
                            print(
                                "****************** ************ data fetched ******* ***********");
                          }
                        },
                        onDelete: () async {
                          final provider = Provider.of<RedeemDetailsProvider>(
                              context,
                              listen: false);

                          await provider.initiateDelete("BANK_ACCOUNT");

                          if (provider.initiateDeleteState ==
                              ViewState.loaded) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialogBox(
                                  content:
                                      "Are you sure you want to delete this account?",
                                  onConfirm: () async {
                                    await provider.deleteRedeem();

                                    if (!context.mounted) return;

                                    if (provider.deleteRedeemState ==
                                        ViewState.loaded) {
                                      Provider.of<AccountProvider>(context)
                                          .clearControllers();
                                      await provider.fetchRedeemDetails();
                                      if (!context.mounted) return;
                                      CustomToast.showToast(
                                        context: context,
                                        isError: false,
                                        message: "Account deleted successfully",
                                      );
                                    } else if (provider.deleteRedeemState ==
                                        ViewState.error) {
                                      CustomToast.showToast(
                                        context: context,
                                        isError: true,
                                        message: "Failed to delete account",
                                      );
                                    }
                                  },
                                );
                              },
                            ).then((_) {
                              provider.fetchRedeemDetails().catchError((error) {
                                if (context.mounted) {
                                  CustomToast.showToast(
                                      context: context,
                                      isError: true,
                                      message:
                                          "Failed to refresh data. Please try again.");
                                }
                              });
                            });
                          } else if (provider.initiateDeleteState ==
                              ViewState.error) {
                            CustomToast.showToast(
                              context: context,
                              isError: true,
                              message: "Failed to initiate delete",
                            );
                          }
                        },
                      );
                    },
                  );
                }
              }),

              const Spacer(),

              // *** Bottom Note + Add Account Button *** //
              Column(
                children: [
                  Text(
                    "Provided account/UPI details will be used for purchases, transferring rewards and cashbacks",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: context.font14,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.black,
                    ),
                  ),
                  SizedBox(height: context.space12),
                  CustomButton(
                    content: Text(
                      "Add account",
                      style: TextStyle(
                        color: AppTheme.white,
                        fontWeight: FontWeight.bold,
                        fontSize: context.font14,
                      ),
                    ),
                    onTap: () => Bottomsheet.showBottom(
                      title: "Select Account Type",
                      context: context,
                      content: SelectAccountType(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
