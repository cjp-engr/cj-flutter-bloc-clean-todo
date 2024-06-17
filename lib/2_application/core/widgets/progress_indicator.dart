import 'package:flutter/material.dart';
import 'package:frontend/2_application/core/widgets/app_bar.dart';

class TodoProgressIndicator extends StatelessWidget {
  const TodoProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoAppBar(
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
