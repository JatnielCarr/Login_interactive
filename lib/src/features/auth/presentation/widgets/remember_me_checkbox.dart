import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/login_cubit.dart';
import '../../application/login_state.dart';

class RememberMeCheckbox extends StatelessWidget {
  const RememberMeCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return CheckboxListTile(
          title: Text(
            'Remember Me',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          value: state.isRememberMeChecked,
          onChanged: (newValue) {
            context.read<LoginCubit>().toggleRememberMe(newValue ?? false);
          },
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          activeColor: Theme.of(context).colorScheme.primary,
        );
      },
    );
  }
}
