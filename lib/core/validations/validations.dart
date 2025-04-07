class Validations {
  //  *** Validate Bank Name  ***//
  static String? validateBankName(String? value) {
    if (value == null || value.isEmpty) {
      return "Bank name must be atleast 3 characters";
    }
    return null;
  }

  // *** Validate account number ***//
  static String? validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Account number cannot be empty";
    }
    if (value.length != 12) {
      return "Account number should be 12 digits";
    }
    return null;
  }

  // *** IFSC Number ***//
  static String? validateIFSCNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "IFSC number cannot be empty";
    }
    final ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');

    if (!ifscRegex.hasMatch(value)) {
      return 'Invalid IFSC code format';
    }

    return null;
  }

  //  *** Validate Bank Branch  ***//
  static String? validateBankBranch(String? value) {
    if (value == null || value.isEmpty) {
      return "Bank branch must be atleast 3 characters";
    }
    return null;
  }
}
