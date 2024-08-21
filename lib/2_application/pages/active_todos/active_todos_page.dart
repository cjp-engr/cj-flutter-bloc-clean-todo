import 'package:flutter/material.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/utils/icon_const.dart';
import 'package:frontend/2_application/core/widgets/app_bar.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:frontend/2_application/core/widgets/text.dart';
import 'package:frontend/2_application/core/widgets/todos/header.dart';

class ActiveTodosPage extends StatelessWidget {
  const ActiveTodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoAppBar(
      appBarTitle: const TodoText(
        text: 'Active Todos',
        fontSize: TodoFontSize.large,
        fontWeight: FontWeight.bold,
      ),
      appBarActions: [
        SecondaryButton(
          onPressed: () {},
          assetName: IconConst.setting,
        ),
      ],
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: TodoSpacing.small),
        child: Column(
          children: [
            HeaderWidget(),
            SizedBox(height: TodoSpacing.large),
            // ListWidget(),
            SizedBox(height: TodoSpacing.large),
          ],
        ),
      ),
    );
  }
}
