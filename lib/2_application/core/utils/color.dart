import 'package:flutter/material.dart';

enum InstaColor { primary, secondary, tertiary, disabled, alert, transparent }

const Map<InstaColor, Color> applyColor = {
  InstaColor.primary: Color.fromRGBO(35, 36, 36, 1),
  InstaColor.secondary: Color.fromRGBO(30, 129, 176, 1),
  InstaColor.tertiary: Color.fromRGBO(252, 252, 252, 1),
  InstaColor.disabled: Color.fromRGBO(223, 207, 190, 1),
  InstaColor.alert: Color.fromRGBO(221, 65, 36, 1),
  InstaColor.transparent: Color.fromARGB(0, 0, 0, 0),
};

class TodoColor {
  static const Color transparentColor = Color.fromARGB(0, 0, 0, 0);

  static const Color lightPrimaryColor = Color.fromRGBO(255, 255, 255, 1);
  static final Color lightPrimaryVariantColor = Colors.blueGrey.shade800;
  static const Color lightOnPrimaryColor = Color.fromRGBO(32, 32, 32, 1);
  static const Color lightTextColorPrimary = Colors.black;
  static final Color appbarColorLight = Colors.blueGrey.shade50;
  static const Color elevatedButtonColorLight = Color.fromRGBO(30, 129, 176, 1);

  static final Color darkPrimaryColor = Colors.blueGrey.shade900;
  static const Color darkPrimaryVariantColor = Colors.black;
  static final Color darkOnPrimaryColor = Colors.blueGrey.shade300;
  static final Color appbarColorDark = Colors.blueGrey.shade800;

  static const Color iconColor = Colors.white;
}
