
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/color_managers.dart';
import '../../../../utils/custom_button.dart';
import '../../../../utils/values_managers.dart';
import '../cubit/auth_cubit.dart';

class  LogoForm extends StatelessWidget {
  const  LogoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child:
      Column(
        children: [
          SizedBox(height: AppSize.s150),
          CustomButton(
            label:  AppLocalizations.of(context).login,
            onPressedAction: () {
              context.read<AuthCubit>().navigateToLogin();
              context.push('/login');
            },
            backgroundColor: ColorManager.mintGreen,
            textColor: ColorManager.black,
            width: AppSize.s300,
            height: AppSize.s50,
            padding: EdgeInsets.fromLTRB(AppSize.s32, AppSize.s16, AppSize.s32, AppSize.s16),
            fontSize: AppSize.s20,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: AppSize.s40),
          CustomButton(
            label: AppLocalizations.of(context).signUp,
            onPressedAction: () {
              context.read<AuthCubit>().navigateToSignUp();
              context.push('/signup');
            },
            backgroundColor: ColorManager.mintGreen,
            textColor: ColorManager.black,
            width: AppSize.s300,
            height: AppSize.s50,
            padding: EdgeInsets.fromLTRB(AppSize.s32, AppSize.s16, AppSize.s32, AppSize.s16),
            fontSize: AppSize.s20,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}  