abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthLoginPage extends AuthState {}
class AuthSignUpPage extends AuthState {}
class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}
