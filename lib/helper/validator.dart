class CustomValidator {
  static String? defaultValidate(String? value) {
    return null;
  }

  static String? validateMobile(String? value) {
    // Indian Mobile number are of 10 digit only
    if (value != null) {
      if (value.length != 10) {
        return 'Mobile Number must be of 10 digit';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value) {
    // Check if the email is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }

    // Use a regular expression for basic email validation
    String emailPattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(emailPattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null; // Return null if the email is valid
  }

  static String? validatePassword(String? value) {
    {
      if (value == null || value.isEmpty) {
        return "Password is required";
      }
      // Perform custom password validation here
      if (value.length < 8) {
        return "Password must be at least 8 characters long";
      }
      // if (!value.contains(RegExp(r'[A-Z]'))) {
      //   return "Password must contain at least one uppercase letter";
      // }
      if (!value.contains(RegExp(r'[a-z]'))) {
        return "Password must contain at least one lowercase letter";
      }
      if (!value.contains(RegExp(r'[0-9]'))) {
        return "Password must contain at least one numeric character";
      }
      if (!value.contains(RegExp(r'[!@#\$%^&*()<>?/|}{~:]'))) {
        return "Password must contain at least one special character";
      }

      return null; // Password is valid.
    }
  }
}
