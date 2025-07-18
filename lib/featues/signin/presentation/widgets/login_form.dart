import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/utils/app_consts.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey formKey;
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isobscureText = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          AppTextFormField(
            hint: AppStrings.email,
            textController: widget.emailController,
            validator: (value) {
              return value?.isValidateEmail();
            },
            hasNext: true,
          ),
          verticalSpace(AppDimensions.height_12),
          AppTextFormField(
            hint: AppStrings.password,
            isobscureText: isobscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isobscureText = !isobscureText;
                });
              },
              child: Icon(
                isobscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            textController: widget.passwordController,
            validator: (value) {
              if (value == null || value.length < AppConsts.minPasswordLength) {
                return AppStrings.passwordLengthRestriction;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
