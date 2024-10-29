import 'package:flutter/material.dart';
import 'package:frontend/2_application/core/constants/border_radius.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/utils/build_context_ext.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:frontend/2_application/core/widgets/text.dart';
import 'package:frontend/2_application/core/widgets/text_field.dart';

class _ResetPasswordDialog extends StatelessWidget {
  final Function()? onConfirm;
  final String? buttonConfirmText;
  final String? buttonCancelText;

  const _ResetPasswordDialog({
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
              child: const TodoText(
                text: 'Reset Password',
                fontSize: TodoFontSize.large,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(
                height: context.screenHeight / 8,
                child: Column(
                  children: [
                    TodoTextField(
                      label: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: TodoSpacing.extraSmall),
                    TodoTextField(
                      label: 'Confirm Password',
                      obscureText: true,
                    ),
                  ],
                )),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              PrimaryButton(
                text: 'Cancel',
                onPressed: () => Navigator.of(context).pop(),
              ),
              PrimaryButton(
                text: 'Confirm',
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

Future<bool?> showResetPasswordDialog(
  BuildContext context, {
  Function()? onConfirm,
}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _ResetPasswordDialog(
      onConfirm: onConfirm,
    ),
  );
}
