import 'package:flutter/material.dart';

typedef Validator = String? Function(String value);

class CustomTextfieldProvider extends ChangeNotifier {
  final Validator validator;
  final bool isPassword;

  String _value = '';
  String? _error;
  bool _obscureText;

  CustomTextfieldProvider(this.validator, {this.isPassword = false})
      : _obscureText = isPassword;

  String get value => _value;
  String? get error => _error;
  bool get obscureText => _obscureText;

  void updateValue(String newValue) {
    _value = newValue.trim();
    _error = validator(_value);
    notifyListeners();
  }

  void toggleObscureText() {
    if (isPassword) {
      _obscureText = !_obscureText;
      notifyListeners();
    }
  }
}
