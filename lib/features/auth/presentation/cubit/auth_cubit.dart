import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trust_zone/utils/app_strings.dart';
import 'package:trust_zone/utils/toast_helper.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;

  AuthCubit(this.loginUseCase, this.signUpUseCase) : super(AuthInitial());

  // Logic methods
  void login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await loginUseCase(email: email, password: password);
    result.fold(
          (failure) {if (failure is InvalidCredentialsFailure) {
            ToastHelper.showToast(AppStrings.invalidEmailOrPassword);
          } else if (failure is ServerErrorFailure) {
            ToastHelper.showToast(AppStrings.serverErrorOccurred);
          }
        emit(AuthFailure(failure.message));
      },
          (data) async {
        final token = data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
            // ✅ جملة الطباعة هنا للتأكد
            final savedToken = prefs.getString('token');
            print('✅ Token saved successfully: $savedToken');
        emit(AuthSuccess());
      },

    );
  }



  void signUp({
    required BuildContext context,
    required String username,
    required String email,
    required String age,
    required String disabilityType,
    required String password,
    required String confirmPassword,
  }) async
  {
    emit(AuthLoading());

    final int ageInt = int.tryParse(age) ?? 0;
    final int disabilityTypeId = int.tryParse(disabilityType) ?? 0;

    final result = await signUpUseCase(
      context: context,
      username: username,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      age: ageInt,
      disabilityTypeId: disabilityTypeId,
    );

    result.fold(
          (failure) {
        print('Signup failed: ${failure.message}');
        emit(AuthFailure(failure.message));
      },
          (data) {
        print('Response Data: $data');

        final token = data['token'];
        print('Token: $token');

        // حفظ الـ token في SharedPreferences
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('token', token);
        });

        emit(AuthSuccess());
      },
    );
  }

  void navigateToLogin() {
    emit(AuthLoginPage());
  }

  void navigateToSignUp() {
    emit(AuthSignUpPage());
  }
}
