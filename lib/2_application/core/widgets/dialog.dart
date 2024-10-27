import 'package:flutter/material.dart';
import 'package:frontend/2_application/core/constants/border_radius.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/utils/build_context_ext.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:frontend/2_application/core/widgets/text.dart';

class _TodoDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function()? onConfirm;
  final String? buttonConfirmText;
  final String? buttonCancelText;

  const _TodoDialog({
    required this.title,
    required this.subTitle,
    this.onConfirm,
    this.buttonConfirmText,
    this.buttonCancelText,
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
                text: title,
                fontSize: TodoFontSize.large,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(
              height: context.screenHeight / 10,
              child: TodoText(
                text: subTitle,
                fontSize: TodoFontSize.large,
                fontWeight: FontWeight.normal,
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
                  onConfirm!();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<bool?> showTodoDialog(
  BuildContext context, {
  required String title,
  required String subTitle,
  Function()? onConfirm,
  final String? buttonConfirmText,
  final String? buttonCancelText,
}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _TodoDialog(
      title: title,
      subTitle: subTitle,
      onConfirm: onConfirm,
      buttonCancelText: buttonCancelText,
      buttonConfirmText: buttonConfirmText,
    ),
  );
}
