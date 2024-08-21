import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/routes/route_name.dart';
import 'package:frontend/2_application/core/utils/build_context_ext.dart';
import 'package:frontend/2_application/core/utils/icon_const.dart';
import 'package:frontend/2_application/core/widgets/app_bar.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:frontend/2_application/core/widgets/text.dart';
import 'package:frontend/2_application/core/widgets/text_field.dart';
import 'package:go_router/go_router.dart';

class TodoFormPageWrapperProvider extends StatelessWidget {
  const TodoFormPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const TodoFormPage();
  }
}

class TodoFormPage extends StatefulWidget {
  const TodoFormPage({super.key});

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
            child: ListView(
              children: [
                const TodoText(
                  text: 'Add New One!',
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
                ),
                const SizedBox(height: TodoSpacing.tiny),
                TodoTextField(
                  label: 'Description',
                  controller: _descriptionController,
                  maxLines: 3,
                ),
                const SizedBox(height: TodoSpacing.medium),
                Row(
                  children: [
                    PrimaryButton(
                      text: 'Create New',
                      onPressed: () => _submit(),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;
  }
}
