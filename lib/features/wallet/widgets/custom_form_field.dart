import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';

import '../../../core/app_theme.dart';

class CustomFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController textController;
  final String hintText;
  const CustomFormField(
      {super.key, required this.hintText, required this.validator, required this.textController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        controller: textController,
        validator: validator,
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
              fontSize: context.font16,
              color: AppTheme.error,
              fontWeight: FontWeight.w400),
          hintStyle: TextStyle(
              fontSize: context.font16,
              color: AppTheme.grey,
              fontWeight: FontWeight.w400),
        ),
        style: TextStyle(
            fontSize: context.font16,
            color: AppTheme.black,
            fontWeight: FontWeight.w400),
        maxLines: null,
        minLines: 1,
      ),
    );
  }
}
