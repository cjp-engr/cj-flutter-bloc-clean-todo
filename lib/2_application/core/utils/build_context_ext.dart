import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';

extension BuildContextExtension on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get padding => Breakpoints.small.isActive(this)
      ? TodoSpacing.small
      : Breakpoints.medium.isActive(this)
          ? screenWidth * 0.12
          : screenWidth * 0.3;

  AppLocalizations get appLocalization => AppLocalizations.of(this)!;
}
