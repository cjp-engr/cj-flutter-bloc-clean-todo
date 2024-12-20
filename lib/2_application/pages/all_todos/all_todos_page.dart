import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/extension/bloc_api_status.dart';
import 'package:frontend/2_application/core/routes/route_name.dart';
import 'package:frontend/2_application/core/utils/icon_const.dart';
import 'package:frontend/2_application/core/widgets/app_bar.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:frontend/2_application/core/widgets/progress_indicator.dart';
import 'package:frontend/2_application/core/widgets/text.dart';
import 'package:frontend/2_application/pages/all_todos/widgets/list.dart';
import 'package:frontend/2_application/pages/all_todos/bloc/all_todos_bloc.dart';
import 'package:frontend/injection.dart';
import 'package:go_router/go_router.dart';

class AllTodosPageWrapper extends StatelessWidget {
  const AllTodosPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => sl<AllTodosBloc>()),
    ], child: const AllTodosPage());
  }
}

class AllTodosPage extends StatelessWidget {
  const AllTodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllTodosBloc, AllTodosState>(
      builder: (context, state) {
        if (state.status == BlocStatus.loading ||
            state.status == BlocStatus.initial) {
          return const TodoProgressIndicator();
        }
        if (state.status == BlocStatus.error) {
          return const Text('test you cannot register, sorry');
        }

        return TodoAppBar(
          appBarLeading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: TodoSpacing.small),
            child: SecondaryButton(
              assetName: IconConst.setting,
              onPressed: () {
                context.goNamed(
                  TodoRouteName.settings.name,
                );
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: TodoSpacing.small),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TodoText(
                  text: 'Hello, Carmen!',
                  fontSize: TodoFontSize.large,
                  color: Colors.black45,
                ),
                TodoText(
                  text: 'All Todos (${state.todos.length})',
                  fontSize: TodoFontSize.extraLarge,
                  fontWeight: FontWeight.bold,
                ),
                ListWidget(todos: state.todos),
                const SizedBox(height: TodoSpacing.large),
              ],
            ),
          ),
          floatingActionButton: const _AddTodoWidget(),
        );
      },
    );
  }
}

class _AddTodoWidget extends StatelessWidget {
  const _AddTodoWidget();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        context.goNamed(
          TodoRouteName.todoForm.name,
          pathParameters: {
            'action': 'add',
            'index': ' ',
          },
        );
      },
      label: const Row(
        children: [
          TodoText(
            text: 'Write a new todo',
            textAlign: TextAlign.left,
          ),
          SizedBox(width: TodoSpacing.extraSmall),
          Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          )
        ],
      ),
    );
  }
}
