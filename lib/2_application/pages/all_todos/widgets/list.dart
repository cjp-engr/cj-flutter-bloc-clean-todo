import 'package:flutter/material.dart';
import 'package:frontend/1_domain/entities/todo_entity.dart';
import 'package:frontend/2_application/core/widgets/dialog.dart';
import 'package:frontend/2_application/core/widgets/text.dart';

class ListWidget extends StatelessWidget {
  final List<TodoEntity> todos;
  const ListWidget({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: todos.length,
        itemBuilder: (context, index) => Dismissible(
          key: const ValueKey(100),
          confirmDismiss: (_) async => showDeleteDialog(context),
          child: Card(
            child: ListTile(
              onTap: () {},
              leading: Checkbox(
                value: todos[index].isCompleted,
                onChanged: (bool? checked) {},
              ),
              title: TodoText(
                text: todos[index].title,
                textAlign: TextAlign.left,
                fontWeight: FontWeight.bold,
              ),
              subtitle: TodoText(
                text: todos[index].description,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
