import 'package:flutter/material.dart';
import 'package:frontend/2_application/core/constants/border_radius.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/utils/build_context_ext.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:frontend/2_application/core/widgets/text.dart';
import 'package:frontend/2_application/core/widgets/text_field.dart';

class _InstaDialog extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Function()? onPressed;
  final String? buttonConfirmText;
  final String? buttonCancelText;
  const _InstaDialog({
    required this.title,
    required this.subTitle,
    this.onPressed,
    this.buttonConfirmText,
    this.buttonCancelText,
  });

  @override
  Widget build(BuildContext context) => StatefulBuilder(
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
              content: TodoTextField(
                label: '',
                maxLines: 4,
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                PrimaryButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                ),
                PrimaryButton(
                  text: buttonConfirmText!,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      );
}

Future<void> showTodoDialog(
  BuildContext context, {
  String? title,
  String? subTitle,
  Function()? onPressed,
  final String? buttonConfirmText,
  final String? buttonCancelText,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return _InstaDialog(
        title: title,
        subTitle: subTitle,
        onPressed: onPressed,
        buttonCancelText: buttonCancelText,
        buttonConfirmText: buttonConfirmText,
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
      return _InstaDialog(
        title: title,
        subTitle: subTitle,
        onPressed: onPressed,
        buttonCancelText: buttonCancelText,
        buttonConfirmText: buttonConfirmText,
      );
    },
  );
}
