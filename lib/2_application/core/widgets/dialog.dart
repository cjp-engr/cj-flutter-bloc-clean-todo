import 'package:flutter/material.dart';
import 'package:frontend/2_application/core/constants/border_radius.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/utils/build_context_ext.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:frontend/2_application/core/widgets/text.dart';
import 'package:frontend/2_application/core/widgets/text_field.dart';

class _TodoDialog extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Function()? onPressed;
  final String? buttonConfirmText;
  final String? buttonCancelText;
  final Function(String)? todoTitle;
  final Function(String)? todoDescription;
  const _TodoDialog({
    required this.title,
    required this.subTitle,
    this.onPressed,
    this.buttonConfirmText,
    this.buttonCancelText,
    this.todoTitle,
    this.todoDescription,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Stack(
        children: [
          AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(TodoBorderRadius.small),
              ),
            ),
            title: SizedBox(
              width: context.screenWidth,
              child: TodoText(
                text: title!,
                fontSize: TodoFontSize.large,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(
              height: context.screenHeight / 6,
              child: Column(
                children: [
                  TodoTextField(
                    label: 'Title',
                    maxLines: 1,
                    onChanged: _onTitleChange,
                  ),
                  const SizedBox(height: TodoSpacing.tiny),
                  TodoTextField(
                    label: 'Description',
                    maxLines: 4,
                    onChanged: _onDescriptionChange,
                  ),
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              PrimaryButton(
                text: 'Cancel',
                onPressed: () => Navigator.of(context).pop(),
              ),
              PrimaryButton(
                text: buttonConfirmText!,
                onPressed: () {
                  onPressed!();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onTitleChange(String value) {
    todoTitle?.call(value);
  }

  void _onDescriptionChange(String value) {
    todoDescription?.call(value);
  }
}

Future<void> showTodoDialog(
  BuildContext context, {
  String? title,
  String? subTitle,
  Function()? onPressed,
  final String? buttonConfirmText,
  final String? buttonCancelText,
  final Function(String)? todoTitle,
  final Function(String)? todoDescription,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return _TodoDialog(
        title: title,
        subTitle: subTitle,
        onPressed: onPressed,
        buttonCancelText: buttonCancelText,
        buttonConfirmText: buttonConfirmText,
        todoTitle: todoTitle,
        todoDescription: todoDescription,
      );
    },
  );
}

Future<bool?> showDeleteDialog(
  BuildContext context, {
  String? title,
  String? subTitle,
  Function()? onPressed,
  final String? buttonConfirmText,
  final String? buttonCancelText,
}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return _TodoDialog(
        title: title,
        subTitle: subTitle,
        onPressed: onPressed,
        buttonCancelText: buttonCancelText,
        buttonConfirmText: buttonConfirmText,
      );
    },
  );
}
