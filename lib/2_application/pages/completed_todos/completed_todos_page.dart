import 'package:flutter/material.dart';
import 'package:frontend/2_application/core/utils/icon_const.dart';
import 'package:frontend/2_application/core/widgets/app_bar.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:frontend/2_application/core/widgets/text.dart';

class CompletedTodosPage extends StatelessWidget {
  const CompletedTodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoAppBar(
      appBarTitle: const TodoText(text: 'Completed Todos'),
      appBarActions: [
        SecondaryButton(
          onPressed: () {},
          assetName: IconConst.setting,
        ),
      ],
    );
  }
}
