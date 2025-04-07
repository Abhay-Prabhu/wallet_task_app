import 'package:flutter/material.dart';
import 'package:match_maker/core/constants/dimensions.dart';

import '../../../core/app_theme.dart';

class WalletDisplayCard extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const WalletDisplayCard({
    required this.label,
    required this.value,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.padding24,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: AppTheme.black.withOpacity(0.8), fontSize: context.font12)),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: AppTheme.darkGold,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit_outlined, color: AppTheme.black),
                onPressed: onEdit,
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: AppTheme.black),
                onPressed: onDelete,
              ),
            ],
          )
        ],
      ),
    );
  }
}
