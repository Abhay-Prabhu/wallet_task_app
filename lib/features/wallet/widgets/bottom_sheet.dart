import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';

class Bottomsheet {
  static Future<void> showBottom(
      {required BuildContext context, required Widget content}) async {
    return showModalBottomSheet(
// isScrollControlled: false,
      constraints: BoxConstraints.expand(),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(context.borderRadius12)),
      ),

      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: context.padding24),
          child: content,
        );
      },
    );
  }
}
