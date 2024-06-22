import 'package:flutter/material.dart';
import 'package:frontend/2_application/core/constants/border_radius.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/utils/color.dart';
import 'package:frontend/2_application/core/utils/build_context_ext.dart';
import 'package:frontend/2_application/core/widgets/text.dart';

// * Button with Text only
class PrimaryButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final double? width;
  final double? height;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 110,
      height: height ?? context.screenHeight * 0.055,
      child: ElevatedButton(
        key: key,
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}

// * Button with Icon only
class SecondaryButton extends StatelessWidget {
  final String assetName;
  final double? scale;
  final Color? color;
  final Function()? onPressed;
  const SecondaryButton({
    super.key,
    required this.assetName,
    this.scale,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Image.asset(
        assetName,
        scale: scale ?? 2.7,
        color: TodoColor.lightTextColorPrimary,
      ),
    );
  }
}

// * Button with Text and Icon
class TertiaryButton extends StatelessWidget {
  final String text;
  final String assetName;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final double? scale;
  final Color? color;
  const TertiaryButton({
    super.key,
    required this.text,
    required this.assetName,
    this.onPressed,
    this.width,
    this.height,
    this.scale,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 120,
      height: height ?? context.screenHeight * 0.055,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? applyColor[InstaColor.primary],
          minimumSize: Size.zero,
          padding: const EdgeInsets.symmetric(vertical: 5),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TodoBorderRadius.small),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetName,
              scale: scale,
              color: applyColor[InstaColor.tertiary],
            ),
            text.isEmpty
                ? const SizedBox()
                : Row(
                    children: [
                      const SizedBox(width: TodoSpacing.verySmall),
                      TodoText(
                        text: text,
                        color: applyColor[InstaColor.tertiary],
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
