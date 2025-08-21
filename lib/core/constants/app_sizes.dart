import 'package:flutter/material.dart';

class AppSizes {
  static SizedBox appHeight10(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(height: height * 0.01);
  }

  static SizedBox appHeight20(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(height: height * 0.02);
  }

  static SizedBox appWidth10(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(width: width * 0.02);
  }

  static EdgeInsets commonPadding(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return EdgeInsets.symmetric(
      vertical: size.height * 0.05,
      horizontal: size.width * 0.06,
    );
  }
}
