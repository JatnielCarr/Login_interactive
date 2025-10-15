import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/login_cubit.dart';
import '../../application/login_state.dart';
import 'animated_border_button.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      // Solo reconstruir cuando cambie el tipo de estado
      buildWhen: (previous, current) {
        return previous.runtimeType != current.runtimeType;
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return AnimatedBorderButton(
          onPressed: onPressed,
          text: 'Login',
          isLoading: isLoading,
          height: 56,
        );
      },
    );
  }
}
