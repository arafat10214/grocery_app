class InputValidators {
  //========================== Name Validator =====================
  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return "Enter your name";
    } else if (name.length < 3) {
      return "Name must be at least 3 letters";
    }
    return null;
  }

  //========================== Email Validator =====================
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return "Enter your email";
    }

    // ----------- email pattern check
    final emailPattern = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!emailPattern.hasMatch(email.trim())) {
      return "Enter a valid email address";
    }
    return null;
  }

  //========================== Password Validator =====================
  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return "Enter your password";
    } else if (password.length < 8) {
      return "Password must be at least 8 characters long";
    }
    //----------- Letter check------
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(password);
    //----------- Number check------
    final hasNumber = RegExp(r'\d').hasMatch(password);
    //----------- special character check------
    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

    if (!hasLetter) {
      return "Password must contain at least one letter";
    } else if (!hasNumber) {
      return "Password must contain at least one number";
    } else if (!hasSpecial) {
      return "Password must contain at least one special character";
    }

    return null;
  }
}
