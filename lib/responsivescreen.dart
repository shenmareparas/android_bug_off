import 'package:flutter/material.dart';

class ResponsiveScreen {
  static double? screenHeight;
  static double? screenWidth;

  static double fullRepHeight(BuildContext context, double height) {
    return MediaQuery.of(context).size.height * (height / screenHeight!);
  }

  static double halfRepHeight(BuildContext context, double height) {
    return MediaQuery.of(context).size.height > screenHeight!
        ? height
        : MediaQuery.of(context).size.height * (height / screenHeight!);
  }

  static double fullRepWidth(BuildContext context, double width) {
    return MediaQuery.of(context).size.height * (width / screenWidth!);
  }

  static double halfRepWidth(BuildContext context, double width) {
    return MediaQuery.of(context).size.width > screenWidth!
        ? width
        : MediaQuery.of(context).size.height * (width / screenWidth!);
  }
}
