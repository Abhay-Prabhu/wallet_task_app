import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match_maker/core/constants/dimensions.dart';

import '../../../core/app_theme.dart';

class CustomFormField extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController textController;
  final TextEditingController? originalPasswordController;
  final String hintText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final bool isNumeric;
  final bool allowSpecialCharacters;
  const CustomFormField(
      {super.key,
      required this.hintText,
      required this.validator,
      required this.textController,
      this.keyboardType,
      this.isNumeric = false,
      this.allowSpecialCharacters = false,
      this.isPassword = false,
      this.originalPasswordController});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late FocusNode _focusNode;
  bool _shouldMask = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    widget.textController.addListener(_handleFocusChange);
  }
  void _handleFocusChange() {
    if (mounted && widget.isPassword) {
      setState(() {
        _shouldMask = !_focusNode.hasFocus;
      });
    }
  }

  void _handleControllerChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    widget.textController.removeListener(_handleControllerChanged);
    _focusNode.dispose();
    super.dispose();
  }

  String _maskValue(String value) {
    if (value.length <= 4) return '*' * value.length;
    return '*' * (value.length - 4) + value.substring(value.length - 4);
  }

  @override
  Widget build(BuildContext context) {
    final upperCaseTextFormatter = TextInputFormatter.withFunction(
      (oldValue, newValue) {
        return newValue.copyWith(
          text: newValue.text.toUpperCase(),
          selection: newValue.selection,
        );
      },
    );

    String actualValue = widget.textController.text;
    String displayValue = (widget.isPassword && _shouldMask)
        ? _maskValue(actualValue)
        : actualValue;

    return Stack(
      children: [
        TextFormField(
          controller: widget.textController,
          focusNode: _focusNode,
          validator: widget.validator,
          onChanged: (value) {
            // Always store actual value
            widget.textController.text = value;
            widget.textController.selection =
                TextSelection.collapsed(offset: value.length);
          },
          textCapitalization: widget.isNumeric
              ? TextCapitalization.none
              : TextCapitalization.words,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          inputFormatters: [
            if (widget.isNumeric) FilteringTextInputFormatter.digitsOnly,
            if (!widget.isNumeric) upperCaseTextFormatter,
            FilteringTextInputFormatter.deny(RegExp(r'^\s')),
            if (widget.isNumeric) FilteringTextInputFormatter.digitsOnly,
            if (!widget.allowSpecialCharacters)
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
            hintText: widget.hintText,
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
              color: !widget.isPassword
                  ? AppTheme.black.withOpacity(0.7)
                  : _focusNode.hasFocus
                      ? AppTheme.black.withOpacity(0.7)
                      : Colors.transparent,
              fontWeight: FontWeight.w200),
          maxLines: null,
          minLines: 1,
        ),
        if (widget.isPassword && _shouldMask && actualValue.isNotEmpty)
          IgnorePointer(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.space12, vertical: 16),
              child: Text(
                _maskValue(actualValue),
                style: const TextStyle(
                  letterSpacing: 2,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
