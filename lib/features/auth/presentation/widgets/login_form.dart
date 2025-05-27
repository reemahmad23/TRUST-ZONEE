import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/color_managers.dart';
import '../../../../utils/custom_button.dart';
import '../../../../utils/custom_text_field.dart';
import '../../../../utils/values_managers.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: emailController,
                labelText: AppLocalizations.of(context).email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context).pleaseEnterYourEmail;
                  }
                  final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!regex.hasMatch(value)) return AppLocalizations.of(context).invalidEmailFormat;
                  return null;
                },
              ),
              const SizedBox(height: AppSize.s20),
              CustomTextField(
                controller: passwordController,
                labelText: AppLocalizations.of(context).password,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context).pleaseEnterYourPassword;
                  }
                  if (value.length < 6) {
                    return AppLocalizations.of(context).passwordMustBeAtLeast6Char;
                  }
                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return AppLocalizations.of(context).passwordMustContainAtLeast1UppercaseLetter;
                  }
                  if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return AppLocalizations.of(context).passwordMustContainAtLeast1LowercaseLetter;
                  }
                  if (!RegExp(r'[0-9]').hasMatch(value)) {
                    return AppLocalizations.of(context).mustContainAtLeast1num;
                  }
                  if (!RegExp(r'[!@#\$&*~%^()_\-+=<>?/\\.,;:{}[\]|]').hasMatch(value)) {
                    return  AppLocalizations.of(context).mustContainAtLeast1SpecialChar;
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppSize.s10),

              const SizedBox(height: AppSize.s20),
              state is AuthLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                label:AppLocalizations.of(context).login,
                onPressedAction: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AuthCubit>().login(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  }
                },
                backgroundColor: ColorManager.mintGreen,
                textColor: ColorManager.black,
                width: double.infinity,
              ),
                SizedBox(height: AppSize.s40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context).dontHaveAccount, style: AppStyles.subText),
                  GestureDetector(
                    onTap: () => context.push('/signup'),
                    child: Text(AppLocalizations.of(context).signUp, style: AppStyles.subText),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
