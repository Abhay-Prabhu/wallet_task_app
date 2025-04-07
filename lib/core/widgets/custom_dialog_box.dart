import 'package:flutter/material.dart';

import '../app_theme.dart';

class CustomDialogBox extends StatelessWidget {
  final VoidCallback onConfirm;

  const CustomDialogBox({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.white,
      title: const Text("Confirm Delete"),
      content: const Text("Are you sure you want to delete this account?"),
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
