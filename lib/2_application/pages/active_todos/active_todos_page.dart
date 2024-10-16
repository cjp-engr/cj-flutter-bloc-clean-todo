import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/1_domain/entities/todo_entity.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/extension/bloc_api_status.dart';
import 'package:frontend/2_application/core/utils/icon_const.dart';
import 'package:frontend/2_application/core/widgets/app_bar.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:frontend/2_application/core/widgets/dialog.dart';
import 'package:frontend/2_application/core/widgets/progress_indicator.dart';
import 'package:frontend/2_application/core/widgets/text.dart';
import 'package:frontend/2_application/core/widgets/text_field.dart';
import 'package:frontend/2_application/pages/active_todos/bloc/active_todos_bloc.dart';
import 'package:frontend/2_application/pages/all_todos/bloc/all_todos_bloc.dart';

class ActiveTodosPage extends StatefulWidget {
  const ActiveTodosPage({super.key});

  @override
  State<ActiveTodosPage> createState() => _ActiveTodosPageState();
}

class _ActiveTodosPageState extends State<ActiveTodosPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllTodosBloc, AllTodosState>(
      listener: (context, allTodoState) {
        if (allTodoState.status == BlocStatus.success) {
          context
              .read<ActiveTodosBloc>()
              .add(ReadActiveTodosEvent(todos: allTodoState.todos));
        }
      },
      builder: (context, allTodoState) {
        return BlocConsumer<ActiveTodosBloc, ActiveTodosState>(
          listener: (context, state1) {
            if (state1.status == BlocStatus.updated) {
              context
                  .read<ActiveTodosBloc>()
                  .add(ReadActiveTodosEvent(todos: state1.todos));
            }
          },
          builder: (context, state2) {
            if (state2.status == BlocStatus.loading) {
              return const TodoProgressIndicator();
            }
            if (state2.status == BlocStatus.error) {
              return const Text('test you cannot register, sorry');
            }

            return TodoAppBar(
              appBarLeading: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: TodoSpacing.small),
                child: SecondaryButton(
                  assetName: IconConst.drawer,
                  onPressed: () {},
                ),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: TodoSpacing.small),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TodoText(
                      text: 'Active (${state2.todos.length})',
                      fontSize: TodoFontSize.extraLarge,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: TodoSpacing.large),
                    TodoTextField(label: 'Search...'),
                    const SizedBox(height: TodoSpacing.large),
                    ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state2.todos.length,
                      itemBuilder: (context, index) => SizedBox(
                        height: 100,
                        child: Card(
                          child: Row(
                            children: [
                              const SizedBox(width: TodoSpacing.small),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      height: TodoSpacing.extraSmall),
                                  TodoText(
                                    fontSize: TodoFontSize.veryLarge,
                                    text: state2.todos[index].title,
                                    textAlign: TextAlign.left,
                                  ),
                                  TodoText(
                                    text: state2.todos[index].description,
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              SecondaryButton(
                                assetName: IconConst.drawer,
                                onPressed: () async {
                                  showTodoDialog(
                                    context,
                                    title: 'Are you sure?',
                                    subTitle:
                                        'Confirming that you have completed the task cannot be undone',
                                    onConfirm: () => _submitCompletedTodo(
                                        state2.todos[index]),
                                    buttonConfirmText: 'Confirm',
                                  );
                                },
                              ),
                              const SizedBox(width: TodoSpacing.small),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _submitCompletedTodo(TodoEntity todo) {
    context.read<ActiveTodosBloc>().add(
          DoneTodoEvent(
            todo: todo.copyWith(isCompleted: true),
          ),
        );
  }
}
