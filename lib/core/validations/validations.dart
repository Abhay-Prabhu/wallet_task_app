class Validations {
  //  *** Validate Bank Name  ***//
  static String? validateBankName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Bank name cannot be empty";
    }
    if (value.trim().length < 3) {
      return "Bank name must be at least 3 characters";
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
      return "Only alphabets and spaces are allowed in bank name";
    }
    return null;
  }

  // *** Validate account number ***//
  static String? validateAccountNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Account number cannot be empty";
    }
    if (!RegExp(r'^\d{9,18}$').hasMatch(value.trim())) {
      return "Account number must be between 9 and 18 digits";
    }
    // final trimmed = value.trim();
    if (RegExp(r'^(\d)\1*$').hasMatch(value)) {
      return "Invalid account number (cannot contain all same digits)";
    }
    return null;
  }

  // *** IFSC Number ***//
  static String? validateIFSCNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "IFSC code cannot be empty";
    }

    final RegExp ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');

    if (!ifscRegex.hasMatch(value.trim().toUpperCase())) {
      return "Invalid IFSC code format (e.g., AAAA0BBBBBB)";
    }

    return null;
  }

  // *** Validate account number ***//
  // static String? validateConfirmAccountNumber(String? value, String? confirmValue) {
  //   if (confirmValue== null || confirmValue.trim().isEmpty) {
  //     return "Confirm account number cannot be empty";
  //   }

  //   if (confirmValue != value ) {
  //     return "Account number and confirm account should match";
  //   }

  //   if (!RegExp(r'^\d{9,18}$').hasMatch(confirmValue.trim())) {
  //     return " Confirm account number must be between 9 and 18 digits";
  //   }
  //   final trimmed = confirmValue.trim();
  //   if (RegExp(r'^(\d)\1*$').hasMatch(trimmed)) {
  //   return "Invalid account number (cannot contain all same digits)";
  // }
  //   return null;
  // }
  static String? validateConfirmAccountNumber(
      String? original, String? confirm) {
    // final orig = original?.trim();
    // final conf = confirm?.trim();

    if (confirm == null || confirm.isEmpty) {
      return "Confirm account number cannot be empty";
    }

    if (original != confirm) {
      print("Validation failed: $confirm != $original");
      return "Account number and confirm account should match";
    }

    if (!RegExp(r'^\d{9,18}$').hasMatch(confirm)) {
      return " Confirm account number must be between 9 and 18 digits";
    }

    if (RegExp(r'^(\d)\1*$').hasMatch(confirm)) {
      return "Invalid account number (cannot contain all same digits)";
    }

    return null;
  }

  //  *** Validate Bank Branch  ***//
  static String? validateBankBranch(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Branch name cannot be empty";
    }
    if (value.trim().length < 3) {
      return "Branch name must be at least 3 characters";
    }
    if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value.trim())) {
      return "No special characters allowed in branch name";
    }
    return null;
  }
}
