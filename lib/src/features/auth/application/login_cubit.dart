// In lib/src/features/auth/application/login_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  void toggleRememberMe(bool newValue) {
    if (state is LoginInitial) {
      emit(LoginInitial(isRememberMeChecked: newValue));
    } else if (state is LoginSuccess) {
      emit(LoginSuccess(isRememberMeChecked: newValue));
    } else if (state is LoginFailure) {
      emit(LoginFailure((state as LoginFailure).error, isRememberMeChecked: newValue));
    }
  }

  // Credenciales válidas para demostración
  // En producción, esto vendría de una API/base de datos
  static const String _validEmail = 'test@javerage.com';
  static const String _validPassword = '5ecret4';

  Future<void> login(String email, String password) async {
    emit(LoginLoading(isRememberMeChecked: state.isRememberMeChecked));
    
    try {
      // Simulamos una llamada a una API
      await Future.delayed(const Duration(seconds: 2));
      
      // Validación de credenciales
      // En una app real, aquí harías la llamada a tu backend
      if (email == _validEmail && password == _validPassword) {
        emit(LoginSuccess(isRememberMeChecked: state.isRememberMeChecked));
      } else {
        emit(LoginFailure(
          'Credenciales inválidas. Inténtalo de nuevo.',
          isRememberMeChecked: state.isRememberMeChecked,
        ));
      }
    } catch (e) {
      emit(LoginFailure(
        'Error al iniciar sesión: ${e.toString()}',
        isRememberMeChecked: state.isRememberMeChecked,
      ));
    }
  }
}
