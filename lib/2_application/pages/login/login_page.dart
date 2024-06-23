import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/1_domain/entities/user_entity.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/extension/bloc_api_status.dart';
import 'package:frontend/2_application/core/routes/route_name.dart';
import 'package:frontend/2_application/core/utils/build_context_ext.dart';
import 'package:frontend/2_application/core/utils/icon_const.dart';
import 'package:frontend/2_application/core/widgets/app_bar.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:frontend/2_application/core/widgets/progress_indicator.dart';
import 'package:frontend/2_application/core/widgets/text.dart';
import 'package:frontend/2_application/core/widgets/text_field.dart';
import 'package:frontend/2_application/pages/login/cubit/login_cubit.dart';
import 'package:frontend/injection.dart';
import 'package:go_router/go_router.dart';

class LoginPageWrapperProvider extends StatelessWidget {
  const LoginPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == BlocStatus.success) {
          context.goNamed(TodoRouteName.allTodo);
        }
      },
      builder: (context, state) {
        if (state.status == BlocStatus.loading) {
          return const TodoProgressIndicator();
        }
        if (state.status == BlocStatus.error) {
          return const Text('test you cannot register, sorry');
        }
        return TodoAppBar(
          isNestedScrollView: true,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.padding +
                      (Breakpoints.small.isActive(context)
                          ? TodoSpacing.verySmall
                          : TodoSpacing.small)),
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: ListView(
                  shrinkWrap: true,
                  reverse: true,
                  children: [
                    const SizedBox(height: TodoSpacing.small),
                    const _HeaderWidget(),
                    const SizedBox(height: TodoSpacing.extraLarge),
                    TodoTextField(
                      key: const Key('testEmail'),
                      label: context.appLocalization.userNameOrEmail,
                      controller: _emailController,
                    ),
                    const SizedBox(height: TodoSpacing.small),
                    TodoTextField(
                      key: const Key('testPassword'),
                      label: context.appLocalization.password,
                      obscureText: true,
                      controller: _passwordController,
                    ),
                    const SizedBox(height: TodoSpacing.medium),
                    const SizedBox(height: TodoSpacing.extraLarge * 4),
                    _ButtonsWidget(onPress: () => _submit()),
                  ].reversed.toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    BlocProvider.of<LoginCubit>(context).loggedInUser(
      UserEntity(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          IconConst.todo,
          scale: 1,
        ),
        TodoText(
          text: context.appLocalization.appTitle,
          fontSize: TodoFontSize.extraLarge,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}

class _ButtonsWidget extends StatelessWidget {
  final VoidCallback onPress;
  const _ButtonsWidget({
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
          key: const Key('testButton'),
          width: double.infinity,
          text: context.appLocalization.login,
          onPressed: onPress,
        ),
        const SizedBox(height: TodoSpacing.large),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TodoText(text: '${context.appLocalization.dontHaveAnAccount} '),
            InkWell(
              onTap: () {
                context.goNamed(TodoRouteName.register);
              },
              child: TodoText(
                text: context.appLocalization.signUp,
              ),
            ),
          ],
        )
      ],
    );
  }
}
