class Validator{

  static String? validateName(String? usrName) {
    if(usrName == null || usrName.isEmpty) {
      return '*Name cannot be empty';
    }
    else {
      if(RegExp(r"^[a-zA-Z ,.'-]+$").hasMatch(usrName)) {
        return null;
      }
      else {
        return "*Name cannot include numbers or special characters";
      }
    }
  }

  static String? validateEmail(String? usrEmail) {
    if (usrEmail == null || usrEmail.isEmpty) {
      return '*Email cannot be empty';
    }
    else {
      if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(usrEmail)) {
        return null;
      }
      else {
        return '*Enter a valid email';
      }
    }
  }

  static String? validateContactNumber(String? usrContactNum) {
    if(usrContactNum == null || usrContactNum.isEmpty) {
      return '*Contact number cannot be empty';
    }
    else {
      if(RegExp(r"^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$").hasMatch(usrContactNum)) {
        return null;
      }
      else {
        return "*Contact number must include only digits";
      }
    }
  }

  static String? validateNationality(String? usrNationality) {
    if(usrNationality == null || usrNationality.isEmpty) {
      return '*Nationality cannot be empty';
    }
    else {
      if(RegExp(r"^[a-zA-Z][a-zA-Z ]+").hasMatch(usrNationality)) {
        return null;
      }
      else {
        return "*Nationality must include only alphabets";
      }
    }
  }

  static String? validateLanguages(String? usrLanguages) {
    if(usrLanguages == null || usrLanguages.isEmpty) {
      return '*Languages known cannot be empty';
    }
    else {
      if(RegExp(r"^[a-zA-Z][a-zA-Z ]+").hasMatch(usrLanguages)) {
        return null;
      }
      else {
        return "*Languages known must include only alphabets";
      }
    }
  }

  static String? validateAddress(String? usrAddress) {
    if(usrAddress == null || usrAddress.isEmpty) {
      return '*Address cannot be empty';
    }
    else {
        return null;
    }
  }

  static String? validateJobTitle(String? usrJobTitle) {
    if(usrJobTitle == null || usrJobTitle.isEmpty) {
      return '*Job title cannot be empty';
    }
    else {
      if(RegExp(r"^[a-zA-Z][a-zA-Z ]+").hasMatch(usrJobTitle)) {
        return null;
      }
      else {
        return "*Job title must include only alphabets";
      }
    }
  }

  static String? validateBirthDate(String? empDOB) {
    if(empDOB == null || empDOB.isEmpty) {
      return '*Birth Date cannot be empty';
    }
    else {
      return null;
    }
  }

  static String? validateJoiningDate(String? empJoiningDate) {
    if(empJoiningDate == null || empJoiningDate.isEmpty) {
      return '*Joining Date cannot be empty';
    }
    else {
      return null;
    }
  }

  static String? validateNotNull(String? str) {
    if(str == null || str.isEmpty) {
      return '*Required';
    }
    else {
      return null;
    }
  }

  static String? usrPassword;

  static String? validatePassword(String? usrPwd) {

    usrPassword = usrPwd;

    if (usrPwd == null || usrPwd.isEmpty) {
      return '*Password cannot be empty';
    }
    else {
      if(RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*()_+}{":;?\/>.<,])(?=.*[^\w\d\s]).{8,}$').hasMatch(usrPwd)){
        return null;
      } else {
        return '*Enter a valid password';
      }
    }
  }

  static String? validateRePassword(String? rePassword) {

    if(rePassword == usrPassword) {
      return null;
    } else {
      return '*Re-entered password does not match';
    }
  }

  static String? validateNothing(String? OTP) {
    //Validates nothing
    return null;
  }

}