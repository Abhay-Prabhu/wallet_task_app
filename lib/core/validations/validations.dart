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
    if (!RegExp(r'^\d{12}$').hasMatch(value.trim())) {
      return "Account number should be 12 digits";
    }
    return null;
  }

  // *** IFSC Number ***//
  static String? validateIFSCNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "IFSC code cannot be empty";
    }

    final ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
    if (!ifscRegex.hasMatch(value.trim().toUpperCase())) {
      return "Invalid IFSC code format (e.g., SBIN0001234)";
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


