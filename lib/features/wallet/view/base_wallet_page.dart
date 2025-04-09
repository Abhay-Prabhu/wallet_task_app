import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_maker/core/constants/dimensions.dart';

import '../../../core/app_theme.dart';

class BaseWalletPage extends StatelessWidget {
  final Widget content;
  const BaseWalletPage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Column(
        children: [
          // *** head bar ***//
          SizedBox(
            width: double.infinity,
            height: context.headerBar,
            child: Stack(
              children: [
                Container(
                    height: context.headerBar, color: AppTheme.primaryBlue),
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/wallet_header_bg.png",
                    color: AppTheme.darkGold.withOpacity(0.2),
                    height: context.headerBar / 2,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                ),
                SafeArea(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.padding24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: AppTheme.white,
                      ),
                      SizedBox(
                        width: context.space16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "wallet",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: AppTheme.darkGold,
                                fontSize: context.font14,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Your accounts",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: AppTheme.darkGold,
                                fontSize: context.font20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: AppTheme.black, width: context.borderWidth)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      AppTheme.gradient1,
                      AppTheme.gradient2,
                      AppTheme.gradient1,
                    ])),
            height: context.headerLine,
          ),

          // *** child ***//
          Expanded(child: content)
        ],
      ),
    );
  }
}
