import 'package:flutter/material.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/widgets/text.dart';
import 'package:frontend/2_application/core/widgets/text_field.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TodoText(
              text: 'Todos',
              fontSize: TodoFontSize.veryLarge,
              fontWeight: FontWeight.bold,
            ),
            TodoText(
              text: 'x items left',
              fontSize: TodoFontSize.large,
            ),
          ],
        ),
        TodoTextField(label: 'Search Todos...'),
        const SizedBox(height: TodoSpacing.large),
      ],
    );
  }
}
