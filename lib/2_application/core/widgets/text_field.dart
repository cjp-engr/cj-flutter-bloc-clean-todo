import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InstaTextField extends StatefulWidget {
  TextEditingController? controller;
  final String label;
  final bool obscureText;
  final int maxLines;
  final String initialValue;
  final Color? color;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  InstaTextField({
    this.controller,
    super.key,
    required this.label,
    this.obscureText = false,
    this.maxLines = 1,
    this.initialValue = '',
    this.color,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  State<InstaTextField> createState() => _InstaTextFieldState();
}

class _InstaTextFieldState extends State<InstaTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller?.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
      onChanged: _onChanged,
      decoration: InputDecoration(
        hintText: widget.label,
      ),
    );
  }

  void _onChanged(String value) {
    widget.onChanged?.call(value);
  }
}
