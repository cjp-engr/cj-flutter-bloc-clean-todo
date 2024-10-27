import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/routes/route_name.dart';
import 'package:frontend/2_application/core/utils/build_context_ext.dart';
import 'package:frontend/2_application/core/utils/icon_const.dart';
import 'package:frontend/2_application/core/widgets/app_bar.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:go_router/go_router.dart';

class TodoDetailsPage extends StatelessWidget {
  const TodoDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoAppBar(
      appBarLeading: Padding(
        padding: const EdgeInsets.all(TodoSpacing.verySmall),
        child: SecondaryButton(
          assetName: IconConst.back,
          onPressed: () {
            context.goNamed(TodoRouteName.activeTodo.name);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.padding +
              (Breakpoints.small.isActive(context)
                  ? TodoSpacing.verySmall
                  : TodoSpacing.small),
        ),
        child: const SizedBox(),
      ),
    );
  }
}
