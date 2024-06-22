import 'package:flutter/material.dart';
import 'package:frontend/2_application/core/constants/border_radius.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/utils/color.dart';

class AppTheme {
  AppTheme._();

  static const String _fontFamily = 'Poppins';

  // *****************
  // static colors
  // *****************

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: TodoColor.lightPrimaryColor,
    appBarTheme: const AppBarTheme(
      color: TodoColor.lightPrimaryColor,
      iconTheme: IconThemeData(color: TodoColor.iconColor),
      scrolledUnderElevation: 0,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: TodoColor.appbarColorLight,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: TodoColor.elevatedButtonColorLight,
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(vertical: 10),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        foregroundColor: TodoColor.lightPrimaryColor,
        textStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
        splashFactory: NoSplash.splashFactory,
        foregroundColor: TodoColor.lightTextColorPrimary,
        textStyle: const TextStyle(
          fontFamily: _fontFamily,
          fontWeight: FontWeight.bold,
        ),
      ).copyWith(
        overlayColor: WidgetStateProperty.all(TodoColor.transparentColor),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.symmetric(
        vertical: TodoSpacing.extraSmall,
        horizontal: TodoSpacing.verySmall,
      ),
      alignLabelWithHint: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(TodoBorderRadius.small),
        ),
        borderSide: BorderSide(
          color: TodoColor.lightPrimaryVariantColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(TodoBorderRadius.verySmall),
        ),
        borderSide: BorderSide(
          color: TodoColor.lightPrimaryVariantColor,
        ),
      ),
      hintStyle: const TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: TodoFontSize.medium,
      ),
      floatingLabelStyle: TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: TodoFontSize.medium,
        color: TodoColor.lightPrimaryVariantColor,
      ),
      labelStyle: TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: TodoFontSize.medium,
        color: TodoColor.lightPrimaryVariantColor,
      ),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        color: TodoColor.lightPrimaryVariantColor,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: TodoFontSize.medium,
      ),
      bodyMedium: TextStyle(
        color: TodoColor.lightPrimaryVariantColor,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: TodoFontSize.medium,
      ),
      bodyLarge: TextStyle(
        color: TodoColor.lightPrimaryVariantColor,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.bold,
        fontSize: TodoFontSize.medium,
      ),
      // labelSmall: TextStyle(color: Colors.red),
      // labelMedium: TextStyle(color: Colors.red),
      // labelLarge: TextStyle(color: Colors.red),
      // displaySmall: TextStyle(color: Colors.red),
      // displayMedium: TextStyle(color: Colors.red),
      // displayLarge: TextStyle(color: Colors.red),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: TodoColor.darkPrimaryColor,
    appBarTheme: AppBarTheme(
      color: TodoColor.appbarColorDark,
      iconTheme: const IconThemeData(color: TodoColor.iconColor),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: TodoColor.appbarColorDark,
    ),
  );
}
