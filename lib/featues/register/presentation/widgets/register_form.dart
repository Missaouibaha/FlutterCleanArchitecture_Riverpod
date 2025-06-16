import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/utils/app_consts.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey formKey;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool isobscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          AppTextFormField(
            hint: AppStrings.name,
            inputType: TextInputType.name,
            validator: (value) {
              if (value.isNullOrEmpty || (value?.length ?? 0) < AppConsts.minNameLength) {
                return AppStrings.nameRestriction;
              }
            },
            textController: widget.nameController,
          ),
          verticalSpace(AppDimensions.height_20),
          AppTextFormField(
            hint: AppStrings.email,
            inputType: TextInputType.emailAddress,
            validator: (value) {
              return value?.isValidateEmail();
            },
            textController: widget.emailController,
          ),
          verticalSpace(AppDimensions.height_20),
          AppTextFormField(
            hint: AppStrings.phone,
            inputType: TextInputType.phone,
            validator: (value) {
              if (value.isNullOrEmpty || (value?.length ?? 0) < AppConsts.minPasswordLength) {
                return AppStrings.phoneRestriction;
              }
            },
            textController: widget.phoneController,
          ),
          verticalSpace(AppDimensions.height_20),
          AppTextFormField(
            hint: AppStrings.password,
            isobscureText: isobscureText,
            inputType: TextInputType.visiblePassword,
            validator: (value) {
              if (value.isNullOrEmpty ||
                  (value?.length ?? 0) < AppConsts.minPasswordLength) {
                return AppStrings.passwordLengthRestriction;
              }
            },
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isobscureText = !isobscureText;
                });
              },
              child: Icon(
                isobscureText ? Icons.visibility_off : Icons.visibility_rounded,
              ),
            ),
            textController: widget.passwordController,
          ),
          verticalSpace(AppDimensions.height_20),
          AppTextFormField(
            hint:AppStrings.confirmPassword,
            isobscureText: isobscureText,
            inputType: TextInputType.visiblePassword,
            validator: (value) {
              if (value != widget.passwordController.text) {
                return  AppStrings.confirmPassLengthRestriction;
              }
            },

            textController: widget.confirmPasswordController,
          ),
        ],
      ),
    );
  }
}
