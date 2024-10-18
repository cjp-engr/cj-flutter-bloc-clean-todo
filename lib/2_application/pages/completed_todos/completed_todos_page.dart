import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/extension/bloc_api_status.dart';
import 'package:frontend/2_application/core/utils/icon_const.dart';
import 'package:frontend/2_application/core/widgets/app_bar.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:frontend/2_application/core/widgets/progress_indicator.dart';
import 'package:frontend/2_application/core/widgets/text.dart';
import 'package:frontend/2_application/core/widgets/text_field.dart';
import 'package:frontend/2_application/pages/all_todos/bloc/all_todos_bloc.dart';
import 'package:frontend/2_application/pages/completed_todos/bloc/completed_todo_bloc.dart';

class CompletedTodosPage extends StatelessWidget {
  const CompletedTodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AllTodosBloc, AllTodosState>(
      listener: (context, allTodoState) {
        if (allTodoState.status == BlocStatus.success) {
          context
              .read<CompletedTodoBloc>()
              .add(ReadCompletedTodosEvent(todos: allTodoState.todos));
        }
      },
      child: BlocBuilder<CompletedTodoBloc, CompletedTodoState>(
        builder: (context, state) {
          if (state.status == BlocStatus.loading) {
            return const TodoProgressIndicator();
          }
          if (state.status == BlocStatus.error) {
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
                    text: 'Completed (${state.todos.length})',
                    fontSize: TodoFontSize.extraLarge,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: TodoSpacing.large),
                  TodoTextField(label: 'Search...'),
                  const SizedBox(height: TodoSpacing.large),
                  ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) => SizedBox(
                      height: 100,
                      child: Card(
                        child: Row(
                          children: [
                            const SizedBox(width: TodoSpacing.small),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: TodoSpacing.extraSmall),
                                TodoText(
                                  fontSize: TodoFontSize.veryLarge,
                                  text: state.todos[index].title,
                                  textAlign: TextAlign.left,
                                ),
                                TodoText(
                                  text: state.todos[index].description,
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
