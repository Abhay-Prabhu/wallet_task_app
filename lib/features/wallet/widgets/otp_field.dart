import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';
import 'package:match_maker/features/wallet/view_model/otp_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/app_theme.dart';

class OTPField extends StatelessWidget {
  final int index;
  const OTPField({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: AppTheme.grey),
          borderRadius: BorderRadius.circular(8)),
      child: Consumer<OtpProvider>(builder: (context, OtpProvider, _) {
        return TextField(
          onChanged: (value) {
            OtpProvider.updateOTP(value);
        
            if (value.isEmpty) {
              FocusScope.of(context).previousFocus();
            }
        
            if (value.isNotEmpty && index < 5) {
              FocusScope.of(context).nextFocus();
            }
          },
          textAlign: TextAlign.center,
          
          textAlignVertical: TextAlignVertical.top,
          maxLength: 1,
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: context.font16,
          ),
          cursorHeight: 20,
          decoration: InputDecoration(
            
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            counterText: "",
            contentPadding: EdgeInsets.zero,
          ),
          strutStyle: StrutStyle(
            forceStrutHeight: true,
            height: 1,
            leading: 0.5
          ),
        );
      }),
    );
  }
}
