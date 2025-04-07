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
          Container(
            width: double.infinity,
            height: context.headerBar,
            decoration: BoxDecoration(color: AppTheme.primaryBlue),
            child: SafeArea(
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
                        style:
                            TextStyle(color: AppTheme.darkGold, fontSize: context.font16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Your accounts",
                        style:
                            TextStyle(color: AppTheme.darkGold, fontSize: context.font20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),

            )),
          ),
          Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.black, width: context.borderWidth)
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                  AppTheme.gradient1,
                  AppTheme.gradient2,
                  AppTheme.gradient1,
                ])
              ),
              height: context.headerLine,
            ),

          // *** child ***//
          Expanded(child: content)
        ],
      ),
    );
  }
}
