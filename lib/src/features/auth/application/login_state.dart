// In lib/src/features/auth/application/login_state.dart
abstract class LoginState {
  final bool isRememberMeChecked;
  
  const LoginState({this.isRememberMeChecked = false});
}

class LoginInitial extends LoginState {
  const LoginInitial({super.isRememberMeChecked});
}

class LoginLoading extends LoginState {
  const LoginLoading({super.isRememberMeChecked});
}

class LoginSuccess extends LoginState {
  const LoginSuccess({super.isRememberMeChecked});
}

class LoginFailure extends LoginState {
  final String error;
  
  const LoginFailure(this.error, {super.isRememberMeChecked});
}
