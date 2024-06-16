import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:frontend/2_application/core/constants/font_size.dart';
import 'package:frontend/2_application/core/constants/spacing.dart';
import 'package:frontend/2_application/core/utils/build_context_ext.dart';
import 'package:frontend/2_application/core/utils/icon_const.dart';
import 'package:frontend/2_application/core/widgets/app_bar.dart';
import 'package:frontend/2_application/core/widgets/buttons.dart';
import 'package:frontend/2_application/core/widgets/text.dart';
import 'package:frontend/2_application/core/widgets/text_field.dart';

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
                _buildHeader(),
                const SizedBox(height: InstaSpacing.extraLarge),
                _buildLoginIdentifiers(),
                const SizedBox(height: InstaSpacing.small),
                _buildPassword(),
                const SizedBox(height: InstaSpacing.medium),
                _buildLogin(),
                const SizedBox(height: InstaSpacing.extraLarge * 4),
                _buildRegisterRoute(),
              ].reversed.toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Column(
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

  Widget _buildLoginIdentifiers() => InstaTextField(
        label: context.appLocalization.userNameOrEmail,
        controller: _emailController,
      );

  Widget _buildPassword() => InstaTextField(
        label: context.appLocalization.password,
        obscureText: true,
        controller: _passwordController,
      );

  Widget _buildLogin() {
    return PrimaryButton(
      width: double.infinity,
      text: context.appLocalization.login,
      onPressed: _submit,
    );
  }

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;
  }

  Widget _buildRegisterRoute() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InstaText(text: '${context.appLocalization.dontHaveAnAccount} '),
          InkWell(
            // onTap: () => context.goNamed(InstaRouteNames.register),
            child: InstaText(
              text: context.appLocalization.signUp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
