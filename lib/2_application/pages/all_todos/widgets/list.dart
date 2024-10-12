import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/1_domain/entities/todo_entity.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/routes/route_name.dart';
import 'package:frontend/2_application/core/utils/icon_const.dart';
import 'package:frontend/2_application/core/widgets/text.dart';
import 'package:go_router/go_router.dart';

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
        itemBuilder: (context, index) => Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                onPressed: doNothing,
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () => context.goNamed(
                  TodoRouteName.todoForm,
                  pathParameters: {
                    'action': 'add',
                  },
                ),
                child: Column(
                  children: [
                    Image.asset(
                      IconConst.edit,
                      scale: 4.5,
                    ),
                    const SizedBox(
                      height: TodoSpacing.tiny,
                    ),
                    const TodoText(
                      text: 'Edit',
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: TodoSpacing.large,
              ),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Card(
                    child: ListTile(
                      title: TodoText(
                        fontSize: TodoFontSize.veryLarge,
                        text: todos[index].title,
                        textAlign: TextAlign.left,
                        // fontWeight: FontWeight.bold,
                      ),
                      subtitle: TodoText(
                        text: todos[index].description,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void doNothing(BuildContext context) {}
}
