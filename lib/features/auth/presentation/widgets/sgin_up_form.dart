import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/color_managers.dart';
import '../../../../utils/custom_button.dart';
import '../../../../utils/custom_text_field.dart';
import '../../../../utils/values_managers.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart' show AuthLoading, AuthState;

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final disabilityTypeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        final currentYear = DateTime.now().year;
        ageController.text = (currentYear - picked.year).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> disabilityTypes = [
      {"id": 1, "name": AppLocalizations.of(context).visual},
      {"id": 2, "name": AppLocalizations.of(context).mobility},
      {"id": 3, "name": AppLocalizations.of(context).hearing},
      {"id": 4, "name": AppLocalizations.of(context).neurological},
    ];
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: AppSize.s60),
          CustomTextField(
            controller: usernameController,
            labelText:AppLocalizations.of(context).userName,
            validator:
                (value) =>
            value == null || value.isEmpty
                ? AppLocalizations.of(context).enterYourUserName
                : null,
          ),
          const SizedBox(height: AppSize.s20),
          CustomTextField(
            controller: emailController,
            labelText: AppLocalizations.of(context).email,
            validator: (value) {
              if (value == null || value.isEmpty) return AppLocalizations.of(context).enterYourEmail;
              final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
              return !regex.hasMatch(value) ? AppLocalizations.of(context).enterAValidEmail : null;
            },
          ),
          const SizedBox(height: AppSize.s20),
          CustomTextField(
            controller: ageController,
            labelText: AppLocalizations.of(context).age,
            readOnly: true,
            validator:
                (value) =>
            value == null || value.isEmpty
                ? AppLocalizations.of(context).selectYourBirthDate
                : null,
            suffixIcon: GestureDetector(
              onTap: () => _selectDate(context),
              child: Icon(Icons.calendar_today, color: ColorManager.black),
            ),
          ),
          const SizedBox(height: AppSize.s20),
          DropdownButtonFormField<int>(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).disabilityType,
              filled: true,
              fillColor: ColorManager.white,
              labelStyle:  TextStyle(color: ColorManager.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              suffixIcon:  Icon(Icons.arrow_drop_down, color: ColorManager.black),
            ),
            style: const TextStyle(color: Colors.black),
            dropdownColor: ColorManager.white,
            iconEnabledColor: Colors.white,
            value: disabilityTypeController.text.isEmpty
                ? null
                : int.tryParse(disabilityTypeController.text),
            onChanged: (int? newValue) {
              setState(() {
                disabilityTypeController.text = newValue.toString();
              });
            },
            validator: (value) =>
            value == null ? AppLocalizations.of(context).pleaseSelectADisabilityType : null,
            items: disabilityTypes.map((type) {
              return DropdownMenuItem<int>(
                value: type['id'],
                child: Text(type['name']),
              );
            }).toList(),
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
              if (!RegExp(
                r'[!@#\$&*~%^()_\-+=<>?/\\.,;:{}[\]|]',
              ).hasMatch(value)) {
                return AppLocalizations.of(context).mustContainAtLeast1SpecialChar;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSize.s20),
          CustomTextField(
            controller: confirmPasswordController,
            labelText: AppLocalizations.of(context).confirmPassword,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context).plzConfirmYourPassword;
              }
              if (value != passwordController.text) {
                return AppLocalizations.of(context).passwordDoNotMatch;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSize.s20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context).alreadyHaveAnAccount, style: AppStyles.subText),
              GestureDetector(
                onTap: () => context.push('/login'),
                child: Text(
                  AppLocalizations.of(context).login,
                  style: TextStyle(
                    color: ColorManager.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s20),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return state is AuthLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                label: AppLocalizations.of(context).signUp,
                onPressedAction: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AuthCubit>().signUp(
                      username: usernameController.text,
                      email: emailController.text,
                      age: ageController.text,
                      disabilityType: disabilityTypeController.text,
                      password: passwordController.text,
                      confirmPassword: confirmPasswordController.text, context: context,
                    );
                  }
                },
                backgroundColor: ColorManager.mintGreen,
                textColor: ColorManager.black,
              );
            },
          ),
        ],
      ),
    );
  }
}
