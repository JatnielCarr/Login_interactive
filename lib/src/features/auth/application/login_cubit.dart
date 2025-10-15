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

  // Mapa de usuarios válidos para demostración
  // En producción, esto vendría de una API/base de datos
  static final Map<String, String> _validUsers = {
    'test@test.com': '123456',
    'admin@admin.com': 'admin123',
    'user@example.com': 'pass123',
    'demo@demo.com': 'demo123',
  };

  Future<void> login(String email, String password) async {
    emit(LoginLoading(isRememberMeChecked: state.isRememberMeChecked));
    
    try {
      // Simulamos una llamada a una API
      await Future.delayed(const Duration(seconds: 2));
      
      // Validación con múltiples usuarios
      // En una app real, aquí harías la llamada a tu backend
      if (_validUsers.containsKey(email) && _validUsers[email] == password) {
        emit(LoginSuccess(isRememberMeChecked: state.isRememberMeChecked));
      } else if (_validUsers.containsKey(email)) {
        emit(LoginFailure(
          'Contraseña incorrecta',
          isRememberMeChecked: state.isRememberMeChecked,
        ));
      } else {
        emit(LoginFailure(
          'Usuario no encontrado',
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
