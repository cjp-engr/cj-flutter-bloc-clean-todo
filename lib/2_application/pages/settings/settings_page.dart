import 'package:flutter/material.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/routes/route_name.dart';
import 'package:frontend/2_application/core/utils/icon_const.dart';
import 'package:frontend/2_application/core/widgets/app_bar.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:frontend/2_application/core/widgets/text_field.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TodoSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 75,
                backgroundImage:
                    NetworkImage('https://picsum.photos/seed/picsum/200/500'),
              ),
            ),
            const SizedBox(height: TodoSpacing.verySmall),
            TodoTextField(label: 'Full Name'),
            const SizedBox(height: TodoSpacing.extraSmall),
            TodoTextField(label: 'Email'),
            const SizedBox(height: TodoSpacing.medium),
            const PrimaryButton(text: 'Reset Password', width: double.infinity)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {},
        label: const SecondaryButton(assetName: IconConst.drawer),
      ),
    );
  }
}
