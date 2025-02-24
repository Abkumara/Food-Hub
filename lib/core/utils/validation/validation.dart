String? validationEmail(String? value) {
  if (value?.isEmpty ?? true) {
    return 'Please enter email here';
  } else if (!regExp.hasMatch(value!)) {
    return 'Invalid Email';
  } else {
    return null;
  }
}

String? validationPassword(String? value) {
  if (value?.isEmpty ?? true) {
    return 'Please enter password here';
  } else if (value!.length < 8) {
    return 'Password must be at least 8 characters';
  } else {
    return null;
  }
}

String? validationFeedBack(String? value) {
  if (value?.isEmpty ?? true) {
    return 'Please enter FeedBack here';
  } else {
    return null;
  }
}

String? validationFirstName(String? value) {
  if (value?.isEmpty ?? true) {
    return 'Please enter Name here';
  } else {
    return null;
  }
}

String? validationLastName(String? value) {
  if (value?.isEmpty ?? true) {
    return 'Please enter Last Name here';
  } else {
    return null;
  }
}

String? validationPhone(String? value) {
  if (value?.isEmpty ?? true) {
    return 'Please enter phone number here';
  } else if (value!.length < 7 || value.length > 13) {
    return 'Please enter valid phone number';
  } else {
    return null;
  }
}

String? validationItemName(String? value) {
  if (value?.isEmpty ?? true) {
    return 'Please enter Item Name here';
  } else {
    return null;
  }
}

String? validationItemDesc(String? value) {
  if (value?.isEmpty ?? true) {
    return 'Please enter Item Description here';
  } else {
    return null;
  }
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = RegExp(p);

class ValidationModel {
  String? text;
  bool? isValidate;

  ValidationModel({this.text, this.isValidate});
}

ValidationModel checkEmailValidation(String value) {
  var isValidate = validationEmail(value);
  if (isValidate == null) {
    return ValidationModel(text: '', isValidate: true);
  } else {
    return ValidationModel(text: isValidate, isValidate: false);
  }
}

ValidationModel notValidFromAPI(String? msg) {
  return ValidationModel(text: msg, isValidate: false);
}

ValidationModel checkPasswordValidation(String value) {
  var isValidate = validationPassword(value);
  if (isValidate == null) {
    return ValidationModel(text: '', isValidate: true);
  } else {
    return ValidationModel(text: isValidate, isValidate: false);
  }
}

ValidationModel checkFeedBackValidation(String value) {
  var isValidate = validationFeedBack(value);
  if (isValidate == null) {
    return ValidationModel(text: '', isValidate: true);
  } else {
    return ValidationModel(text: isValidate, isValidate: false);
  }
}

ValidationModel checkFirstNameValidation(String value) {
  var isValidate = validationFirstName(value);
  if (isValidate == null) {
    return ValidationModel(text: '', isValidate: true);
  } else {
    return ValidationModel(text: isValidate, isValidate: false);
  }
}

ValidationModel checkLastNameValidation(String value) {
  var isValidate = validationLastName(value);
  if (isValidate == null) {
    return ValidationModel(text: '', isValidate: true);
  } else {
    return ValidationModel(text: isValidate, isValidate: false);
  }
}

ValidationModel checkPhoneValidation(String value) {
  var isValidate = validationPhone(value);
  if (isValidate == null) {
    return ValidationModel(text: '', isValidate: true);
  } else {
    return ValidationModel(text: isValidate, isValidate: false);
  }
}

ValidationModel checkItemNameValidation(String value) {
  var isValidate = validationItemName(value);
  if (isValidate == null) {
    return ValidationModel(text: '', isValidate: true);
  } else {
    return ValidationModel(text: isValidate, isValidate: false);
  }
}

ValidationModel checkItemDescValidation(String value) {
  var isValidate = validationItemDesc(value);
  if (isValidate == null) {
    return ValidationModel(text: '', isValidate: true);
  } else {
    return ValidationModel(text: isValidate, isValidate: false);
  }
}

bool isStringInValid(String? value) {
  return value == null || value.isEmpty;
}
