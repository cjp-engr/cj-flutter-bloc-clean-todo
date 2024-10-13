import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/1_domain/entities/todo_entity.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/extension/bloc_api_status.dart';
import 'package:frontend/2_application/core/routes/route_name.dart';
import 'package:frontend/2_application/core/utils/build_context_ext.dart';
import 'package:frontend/2_application/core/utils/icon_const.dart';
import 'package:frontend/2_application/core/widgets/app_bar.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:frontend/2_application/core/widgets/text.dart';
import 'package:frontend/2_application/core/widgets/text_field.dart';
import 'package:frontend/2_application/pages/all_todos/bloc/all_todos_bloc.dart';
import 'package:frontend/injection.dart';
import 'package:go_router/go_router.dart';

class TodoFormPageWrapperProvider extends StatelessWidget {
  final bool isAddForm;
  final int index;
  const TodoFormPageWrapperProvider({
    super.key,
    required this.isAddForm,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AllTodosBloc>(),
      child: TodoFormPage(
        isAddForm: isAddForm,
        index: index,
      ),
    );
  }
}

class TodoFormPage extends StatefulWidget {
  final bool isAddForm;
  final int index;
  const TodoFormPage({
    super.key,
    required this.isAddForm,
    required this.index,
  });

  @override
  State<TodoFormPage> createState() => _TodoFormPageState();
}

class _TodoFormPageState extends State<TodoFormPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllTodosBloc, AllTodosState>(
      listener: (context, state) {
        if (state.status == BlocStatus.error) {
          final snackBar = SnackBar(
            content: const Text('Something is wrong!'),
            action: SnackBarAction(
              label: 'OK!',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        if (state.status == BlocStatus.updated) {
          context.goNamed(TodoRouteName.allTodo);
        }
      },
      builder: (context, state) {
        return TodoAppBar(
          appBarLeading: Padding(
            padding: const EdgeInsets.all(TodoSpacing.verySmall),
            child: SecondaryButton(
              assetName: IconConst.back,
              onPressed: () {
                context.goNamed(TodoRouteName.allTodo);
              },
            ),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.padding +
                    (Breakpoints.small.isActive(context)
                        ? TodoSpacing.verySmall
                        : TodoSpacing.small),
              ),
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: state.status == BlocStatus.success
                    ? ListView(
                        children: [
                          TodoText(
                            text: widget.isAddForm
                                ? 'Add New One!'
                                : 'Update Todo',
                            fontSize: TodoFontSize.veryLarge,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.start,
                          ),
                          const TodoText(
                            text: 'Tell me about Your Task 😊',
                            fontSize: TodoFontSize.veryLarge,
                            color: Colors.black45,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: TodoSpacing.medium),
                          TodoTextField(
                            label: 'Title',
                            controller: _titleController,
                            initialValue: widget.isAddForm
                                ? ''
                                : state.todos[widget.index].title,
                          ),
                          const SizedBox(height: TodoSpacing.tiny),
                          TodoTextField(
                            label: 'Description',
                            controller: _descriptionController,
                            initialValue: widget.isAddForm
                                ? ''
                                : state.todos[widget.index].description,
                            maxLines: 3,
                          ),
                          const SizedBox(height: TodoSpacing.medium),
                          Row(
                            children: [
                              PrimaryButton(
                                text:
                                    widget.isAddForm ? 'Create New' : 'Update',
                                onPressed: () {
                                  _validateForm();
                                  widget.isAddForm
                                      ? _submitAddTodo()
                                      : _submitUpdateTodo(
                                          state.todos[widget.index].id!);
                                },
                              ),
                              const SizedBox(
                                width: 100,
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        );
      },
    );
  }

  void _validateForm() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
  }

  void _submitAddTodo() {
    context.read<AllTodosBloc>().add(
          AddTodoEvent(
            todo: TodoEntity(
              title: _titleController.text,
              description: _descriptionController.text,
              isCompleted: false,
            ),
          ),
        );
  }

  void _submitUpdateTodo(String id) {
    context.read<AllTodosBloc>().add(
          UpdateTodoEvent(
            todo: TodoEntity(
              id: id,
              title: _titleController.text,
              description: _descriptionController.text,
              isCompleted: false,
            ),
          ),
        );
  }
}
