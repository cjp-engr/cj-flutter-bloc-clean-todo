import 'package:flutter/material.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/routes/route_name.dart';
import 'package:frontend/2_application/core/utils/icon_const.dart';
import 'package:frontend/2_application/core/widgets/app_bar.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return TodoAppBar(
        appBarLeading: Padding(
          padding: const EdgeInsets.all(TodoSpacing.verySmall),
          child: SecondaryButton(
            assetName: IconConst.back,
            onPressed: () {
              context.goNamed(TodoRouteName.allTodo.name);
            },
          ),
        ),
        body: const Text('test settings'));
  }
}
