import 'package:mbvv/utils/string_constants.dart';

class ValidationUtils {
  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value!.trim().isEmpty) {
      return 'Please Enter Your Email Address';
    } else if (!regex.hasMatch(value))
      return 'Incorrect Email Address';
    else
      return null;
  }

  static String? validatePassword(
      String? value, int flag, String? newPassword) {
//    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$';
//    RegExp regExp = new RegExp(pattern);
    if (value!.trim().isEmpty) {
      return 'Please Enter Password';
    } else if (value.length < 8) {
      return flag == 0
          ? 'Password must be 8 characters'
          : 'Confirm password must be 8 charters';
    } else if (value != newPassword) {
      return flag == 0
          ? 'New Password and Confirm Password should be same'
          : 'Confirm password must be same as New Password';
    }
//    else if(!regExp.hasMatch(value)){
//      return 'Password must contain at least one uppercase character one lowercase character one number and one special character';
//    }
    return null;
  }

  static String? validateSinglePassword(String? value, int flag) {
//    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$';
//    RegExp regExp = new RegExp(pattern);
    if (value!.trim().isEmpty) {
      return flag == 0
          ? 'Please Enter Password'
          : 'Please Enter Confirm Password';
    } else if (value.length < 8) {
      return flag == 0
          ? 'Password must be 8 characters'
          : 'Confirm password must be 8 charters';
    }
//    else if(!regExp.hasMatch(value)){
//      return 'Password must contain at least one uppercase character one lowercase character one number and one special character';
//    }
    return null;
  }

  static String? requiredField(String? value, String message) {
    if (value!.trim().isEmpty) {
      return message + "\tRequired";
    }
    return null;
  }

  static String? requiredMobileField(
      String? value, String message, int length) {
    if (value!.trim().isEmpty) {
      return message + "\tRequired";
    }
    if (value.trim().length < length) {
      return '$message should be $length digits';
    }
    return null;
  }

  static String? requiredCustomField(String? value, String message) {
    if (value!.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static bool isValidMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[+0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.trim().isEmpty || value.length == 0 || !regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  static String? isValidPan(String value) {
    RegExp regExp = RegExp(panregex);
    if (value.trim().isEmpty || value.length == 0 || !regExp.hasMatch(value)) {
      return 'Please enter valid PAN number';
    }
    return null;
  }

  static String? isValidAadhar(String value) {
    RegExp regExp = RegExp(aadharCardregex);
    if (value.trim().isEmpty || value.length == 0 || !regExp.hasMatch(value)) {
      return 'Please enter valid Aadhar number';
    }
    return null;
  }

  static String? isValidelectionid(String value) {
    RegExp regExp = RegExp(electionidregex);
    if (value.trim().isEmpty || value.isEmpty || !regExp.hasMatch(value)) {
      return 'Please enter valid ElectionID number';
    }
    return null;
  }

  static String? isValidpassport(String value) {
    RegExp regExp = RegExp(passportregex);
    if (value.trim().isEmpty || value.length == 0 || !regExp.hasMatch(value)) {
      return 'Please enter valid Passport number';
    }
    return null;
  }

  static String? isValidVehicleNumber(String value) {
    RegExp regExp = RegExp(vehicleregex);
    if (value.trim().isEmpty || value.length == 0 || !regExp.hasMatch(value)) {
      return 'Please enter valid Vehicle number';
    }
    return null;
  }

  static String? isValidateMobile(String? value, String name) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value!.trim().isEmpty || value.length == 0) {
      return 'Please enter $name';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid $name';
    }
    return null;
  }
}
