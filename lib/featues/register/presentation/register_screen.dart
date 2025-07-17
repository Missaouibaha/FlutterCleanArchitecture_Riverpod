import 'package:clean_arch_riverpod/core/helper/extensions.dart';
import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/core/widgets/app_text_button.dart';
import 'package:clean_arch_riverpod/core/widgets/divider_with_text.dart';
import 'package:clean_arch_riverpod/core/widgets/error_dialog.dart';
import 'package:clean_arch_riverpod/core/widgets/span_register_login_row.dart';
import 'package:clean_arch_riverpod/core/widgets/terms_and_conditions.dart';
import 'package:clean_arch_riverpod/featues/register/presentation/providers/genderProvider.dart';
import 'package:clean_arch_riverpod/featues/register/presentation/providers/register_notifier.dart';
import 'package:clean_arch_riverpod/featues/register/presentation/widgets/gender_widget.dart';
import 'package:clean_arch_riverpod/featues/register/presentation/widgets/register_form.dart';
import 'package:clean_arch_riverpod/featues/register/presentation/widgets/register_state_listener.dart';
import 'package:clean_arch_riverpod/featues/signin/presentation/widgets/social_login_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController confirmPasswordController = TextEditingController(
    text: '',
  );
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.padding_25,
            vertical: AppDimensions.padding_10,
          ),

          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  AppStrings.createAccount,
                  style: TextStyles.font32BlueBold,
                ),
                verticalSpace(AppDimensions.height_25),
                Text(
                  AppStrings.signupWelcomeMsg,
                  style: TextStyles.font16LightGrayMedium,
                ),
                verticalSpace(AppDimensions.height_25),
                RegisterForm(
                  formKey: formKey,
                  nameController: nameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                ),
                verticalSpace(AppDimensions.height_25),
                GenderWidget(),
                verticalSpace(AppDimensions.height_30),
                Consumer(
                  builder: (context, ref, child) {
                    final registerState = ref.watch(registerNotifierProvider);
                    return AppTextButton(
                      textButton: AppStrings.createAccount,
                      textStyle: TextStyles.font16WhiteSemiBold,
                      onPressed: () {
                        _validateThenRegister(ref);
                      },
                    );
                  },
                ),
                verticalSpace(AppDimensions.height_30),
                DividerWithText(text: AppStrings.orSignupWith),
                verticalSpace(AppDimensions.height_30),
                SocialLoginRow(),
                verticalSpace(AppDimensions.height_30),
                TermesConditionsView(),
                verticalSpace(AppDimensions.height_20),
                SpanRegisterLoginRow(
                  hasAnAcount: true,
                  navigateTo: () {
                    context.pop();
                  },
                ),
                const RegisterStateListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateThenRegister(WidgetRef ref) {
    final gender = ref.read(genderProvider.notifier).state;

    if ((formKey.currentState?.validate() ?? false)) {
      if (gender == null) {
        ErrorDialog.show(context, AppStrings.chooseGender);
      } else {
        ref
            .read(registerNotifierProvider.notifier)
            .register(
              nameController.text,
              emailController.text,
              phoneController.text,
              gender.gederValue,
              passwordController.text,
            );
      }
    }
  }
}
