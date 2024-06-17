import 'package:flutter/material.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';

const String _fontFamily = 'Poppins';

class TodoText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  const TodoText({
    super.key,
    required this.text,
    this.fontSize = InstaFontSize.medium,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.maxLines,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: _fontFamily,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
