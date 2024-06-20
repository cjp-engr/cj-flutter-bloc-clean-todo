import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TodoTextField extends StatefulWidget {
  TextEditingController? controller;
  final String label;
  final bool obscureText;
  final int maxLines;
  final String initialValue;
  final Color? color;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  TodoTextField({
    super.key,
    this.controller,
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
  State<TodoTextField> createState() => _TodoTextFieldState();
}

class _TodoTextFieldState extends State<TodoTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller?.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
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
