import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';

import '../app_theme.dart';

class CustomDialogBox extends StatelessWidget {
  final VoidCallback onConfirm;
  final String content;

  const CustomDialogBox(
      {super.key, required this.onConfirm, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.white,
      title: const Text("Confirm Delete"),
      content: Text(
        content,
        style: TextStyle(
          fontSize: context.font14,
          fontWeight: FontWeight.w500,
          color: AppTheme.black,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
