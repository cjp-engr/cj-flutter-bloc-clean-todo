import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/routes/route_name.dart';
import 'package:frontend/2_application/core/utils/build_context_ext.dart';
import 'package:frontend/2_application/core/utils/icon_const.dart';
import 'package:frontend/2_application/core/widgets/app_bar.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:frontend/2_application/core/widgets/text.dart';
import 'package:frontend/2_application/core/widgets/text_field.dart';
import 'package:frontend/2_application/pages/login/cubit/login_cubit.dart';
import 'package:go_router/go_router.dart';

class LoginPageWrapperProvider extends StatelessWidget {
  const LoginPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
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
    return InstaAppBar(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.padding +
                  (Breakpoints.small.isActive(context)
                      ? InstaSpacing.verySmall
                      : InstaSpacing.small)),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: ListView(
              shrinkWrap: true,
              reverse: true,
              children: [
                const SizedBox(height: InstaSpacing.small),
                const _HeaderWidget(),
                const SizedBox(height: InstaSpacing.extraLarge),
                InstaTextField(
                  label: context.appLocalization.userNameOrEmail,
                  controller: _emailController,
                ),
                const SizedBox(height: InstaSpacing.small),
                InstaTextField(
                  label: context.appLocalization.password,
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: InstaSpacing.medium),
                const SizedBox(height: InstaSpacing.extraLarge * 4),
                _ButtonsWidget(onPress: () => _submit()),
              ].reversed.toList(),
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
        InstaText(
          text: context.appLocalization.appTitle,
          fontSize: InstaFontSize.extraLarge,
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
          width: double.infinity,
          text: context.appLocalization.login,
          onPressed: onPress,
        ),
        const SizedBox(height: InstaSpacing.large),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InstaText(text: '${context.appLocalization.dontHaveAnAccount} '),
            InkWell(
              onTap: () {
                context.goNamed(TodoRouteName.register);
              },
              child: InstaText(
                text: context.appLocalization.signUp,
              ),
            ),
          ],
        )
      ],
    );
  }
}
