import 'package:clean_arch_riverpod/core/helper/routing/routes.dart';
import 'package:clean_arch_riverpod/core/helper/spacing.dart';
import 'package:clean_arch_riverpod/core/theming/app_dimensions.dart';
import 'package:clean_arch_riverpod/core/theming/text_styles.dart';
import 'package:clean_arch_riverpod/core/utils/app_strings.dart';
import 'package:clean_arch_riverpod/core/widgets/app_text_button.dart';
import 'package:clean_arch_riverpod/core/widgets/divider_with_text.dart';
import 'package:clean_arch_riverpod/core/widgets/span_register_login_row.dart';
import 'package:clean_arch_riverpod/core/widgets/terms_and_conditions.dart';
import 'package:clean_arch_riverpod/featues/signin/presentation/providers/login_notifier.dart';
import 'package:clean_arch_riverpod/featues/signin/presentation/widgets/login_form.dart';
import 'package:clean_arch_riverpod/featues/signin/presentation/widgets/login_state_listener.dart';
import 'package:clean_arch_riverpod/featues/signin/presentation/widgets/remember_me_row.dart';
import 'package:clean_arch_riverpod/featues/signin/presentation/widgets/social_login_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(
    text: '',
  );
  final formKey = GlobalKey<FormState>();
  var rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.padding_20,
            vertical: AppDimensions.height_10,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.welcomeBack, style: TextStyles.font32BlueBold),
                verticalSpace(AppDimensions.height_15),
                Text(
                  AppStrings.welcomeMsg,
                  style: TextStyles.font16LightGrayMedium,
                ),
                verticalSpace(AppDimensions.height_25),
                LoginForm(
                  emailController: emailController,
                  passwordController: passwordController,
                  formKey: formKey,
                ),
                verticalSpace(AppDimensions.height_20),
                RememberMeRow(
                  rememberMe: rememberMe,
                  onRememberMeChanged: (value) {
                    setState(() {
                      rememberMe = value ?? false;
                    });
                  },
                  onForgetPasswordPressed: () {
                    //navigate to forgetPAssword
                  },
                ),
                verticalSpace(AppDimensions.height_30),
                Consumer(
                  builder: (context, ref, child) {
                    //final loginState = ref.watch(loginNotifierProvider);
                    return AppTextButton(
                      textButton: AppStrings.login,
                      textStyle: TextStyles.font16WhiteSemiBold,
                      onPressed: () {
                        _validateThenLogin(ref);
                      },
                    );
                  },
                ),

                verticalSpace(AppDimensions.height_40),
                DividerWithText(text: AppStrings.orSigninWith),
                verticalSpace(AppDimensions.height_35),
                SocialLoginRow(),
                verticalSpace(AppDimensions.height_30),
                TermesConditionsView(),
                verticalSpace(AppDimensions.height_25),
                SpanRegisterLoginRow(
                  hasAnAcount: false,
                  navigateTo: () {
                    context.pushNamed(Routes.registerScreen);
                  },
                ),
                const LoginStateListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateThenLogin(WidgetRef ref) {
    if (formKey.currentState?.validate() ?? false) {
      ref
          .read(loginNotifierProvider.notifier)
          .login(emailController.text, passwordController.text);
    }
  }

}
