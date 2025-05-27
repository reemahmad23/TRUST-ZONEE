import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/color_managers.dart';
import '../../../../utils/values_managers.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/logo_form.dart';



class LogoView extends StatelessWidget {
  const LogoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: AppSize.s250),
                  Image.asset(
                    Assets.logoImage,
                    width: AppSize.s240,
                    height: AppSize.s140,
                  ),
                  LogoForm()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
