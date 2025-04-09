import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_maker/core/constants/dimensions.dart';

import '../../../core/app_theme.dart';

class CustomFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController textController;
  final String hintText;
   final TextInputType? keyboardType;
  final bool isNumeric;
  final bool allowSpecialCharacters;
  const CustomFormField(
      {super.key, required this.hintText, required this.validator, required this.textController, this.keyboardType, this.isNumeric = false, this.allowSpecialCharacters = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        controller: textController,
        validator: validator,
        keyboardType: keyboardType ?? TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'^\s')),

          if (isNumeric)
            FilteringTextInputFormatter.digitsOnly,

          if (!allowSpecialCharacters)
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
        ],
        decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.error),
            borderRadius:
                BorderRadius.all(Radius.circular(context.borderRadius8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.grey),
            borderRadius:
                BorderRadius.all(Radius.circular(context.borderRadius12)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.grey),
            borderRadius:
                BorderRadius.all(Radius.circular(context.borderRadius12)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.error),
            borderRadius:
                BorderRadius.all(Radius.circular(context.borderRadius8)),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.grey),
            borderRadius:
                BorderRadius.all(Radius.circular(context.borderRadius12)),
          ),
          hintMaxLines: 4,
          hintText: hintText,
          errorMaxLines: 3,
          errorStyle: TextStyle(
            fontFamily: 'Montserrat',
              fontSize: context.font16,
              color: AppTheme.error,
              fontWeight: FontWeight.w400),
          hintStyle: TextStyle(
            fontFamily: 'Montserrat',
              fontSize: context.font16,
              color: AppTheme.grey,
              fontWeight: FontWeight.w400),
        ),
        style: TextStyle(
          fontFamily: 'Montserrat',
            fontSize: context.font16,
            color: AppTheme.black.withOpacity(0.7),
            fontWeight: FontWeight.w200),
        maxLines: null,
        minLines: 1,
      ),
    );
  }
}


