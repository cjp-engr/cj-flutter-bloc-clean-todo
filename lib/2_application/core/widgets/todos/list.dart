import 'package:flutter/material.dart';
import 'package:frontend/2_application/core/widgets/dialog.dart';
import 'package:frontend/2_application/core/widgets/text.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 100,
        itemBuilder: (context, index) => Dismissible(
          key: const ValueKey(100),
          confirmDismiss: (_) async => showDeleteDialog(context),
          child: Card(
            child: ListTile(
              onTap: () => showTodoDialog(
                context,
                title: 'Edit Todo',
                buttonConfirmText: 'Edit',
              ),
              leading: Checkbox(
                value: true,
                onChanged: (bool? checked) {},
              ),
              title: const TodoText(
                text: 'I am a description',
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
