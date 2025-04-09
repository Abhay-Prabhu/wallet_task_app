import 'package:flutter/material.dart';

class CustomToast {
  

static void showCustomToast({required BuildContext context,required  String message}) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 80, 
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.85),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);


  Future.delayed(const Duration(seconds: 2)).then((_) {
    overlayEntry.remove();
  });
}

}