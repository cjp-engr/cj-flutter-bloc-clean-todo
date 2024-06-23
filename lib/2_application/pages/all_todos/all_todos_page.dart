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
import 'package:frontend/2_application/core/widgets/todos/header.dart';
import 'package:frontend/2_application/core/widgets/todos/list.dart';
import 'package:frontend/2_application/pages/all_todos/bloc/all_todos_bloc.dart';
import 'package:frontend/injection.dart';

class AllTodosPageWrapperProvider extends StatelessWidget {
  const AllTodosPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AllTodosBloc>(),
      child: const AllTodosPage(),
    );
  }
}

class AllTodosPage extends StatefulWidget {
  const AllTodosPage({super.key});

  @override
  State<AllTodosPage> createState() => _AllTodosPageState();
}

class _AllTodosPageState extends State<AllTodosPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllTodosBloc>(context).add(ReadTodosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllTodosBloc, AllTodosState>(
      builder: (context, state) {
        if (state.status == BlocStatus.loading) {
          return const TodoProgressIndicator();
        }
        if (state.status == BlocStatus.error) {
          return const Text('test you cannot register, sorry');
        }

        return TodoAppBar(
          appBarTitle: const TodoText(
            text: 'All Todos',
            fontSize: TodoFontSize.large,
            fontWeight: FontWeight.bold,
          ),
          appBarActions: [
            SecondaryButton(
              onPressed: () {},
              assetName: IconConst.setting,
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: TodoSpacing.small),
            child: Column(
              children: [
                const HeaderWidget(),
                const SizedBox(height: TodoSpacing.large),
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
    String title = '';
    String description = '';
    return FloatingActionButton(
      onPressed: () => showTodoDialog(
        context,
        title: 'Add Todo',
        buttonConfirmText: 'Add',
        todoTitle: (value) => title = value,
        todoDescription: (value) => description = value,
        onPressed: () => BlocProvider.of<AllTodosBloc>(context).add(
          AddTodoEvent(
            todo: TodoEntity(
              title: title.trim(),
              description: description.trim(),
              isCompleted: false,
            ),
          ),
        ),
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 28,
      ),
    );
  }
}
