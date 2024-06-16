// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _fullNameController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                const SizedBox(height: InstaSpacing.veryLarge),
                _DetailWidget(
                  text: context.appLocalization.registerSubHeader,
                ),
                const SizedBox(height: InstaSpacing.extraLarge),
                InstaTextField(
                  label: context.appLocalization.email,
                  controller: _emailController,
                ),
                const SizedBox(height: InstaSpacing.small),
                InstaTextField(
                  label: context.appLocalization.fullName,
                  controller: _fullNameController,
                ),
                const SizedBox(height: InstaSpacing.small),
                InstaTextField(
                  label: context.appLocalization.userName,
                  controller: _userNameController,
                ),
                const SizedBox(height: InstaSpacing.small),
                InstaTextField(
                  label: context.appLocalization.password,
                  controller: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: InstaSpacing.small),
                _DetailWidget(
                  text: context.appLocalization.registerLearnMore,
                ),
                const SizedBox(height: InstaSpacing.small),
                _DetailWidget(
                  text: context.appLocalization.registerPolicy,
                ),
                const SizedBox(height: InstaSpacing.small),
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

class _DetailWidget extends StatelessWidget {
  final String text;
  const _DetailWidget({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InstaText(
      text: text,
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
          text: context.appLocalization.signUp,
          onPressed: onPress,
        ),
        const SizedBox(height: InstaSpacing.large),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InstaText(text: '${context.appLocalization.haveAnAccount} '),
            InkWell(
              onTap: () {},
              child: InstaText(text: context.appLocalization.login),
            ),
          ],
        )
      ],
    );
  }
}
