import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/login_cubit.dart';
import '../../application/login_state.dart';

class RememberMeCheckbox extends StatelessWidget {
  const RememberMeCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      // Solo reconstruir cuando cambie isRememberMeChecked o el tipo de estado
      buildWhen: (previous, current) {
        return previous.isRememberMeChecked != current.isRememberMeChecked ||
            previous.runtimeType != current.runtimeType;
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return CheckboxListTile(
          title: Text(
            'Remember Me',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isLoading ? Colors.grey.shade400 : null,
                ),
          ),
          value: state.isRememberMeChecked,
          onChanged: isLoading
              ? null // Deshabilitar durante loading
              : (newValue) {
                  context.read<LoginCubit>().toggleRememberMe(newValue ?? false);
                },
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          activeColor: isLoading
              ? Colors.grey.shade400
              : Theme.of(context).colorScheme.primary,
        );
      },
    );
  }
}
