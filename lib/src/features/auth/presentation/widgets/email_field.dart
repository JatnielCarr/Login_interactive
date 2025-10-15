import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/form_validators.dart';
import '../../application/login_cubit.dart';
import '../../application/login_state.dart';

/// Widget de campo de email con validación avanzada
/// Siguiendo el principio de Single Responsibility (SOLID)
class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final bool autofocus;

  const EmailField({
    super.key,
    required this.controller,
    this.focusNode,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.autofocus = false,
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

        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          autofocus: autofocus,
          enabled: !isLoading, // Deshabilitar durante loading
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enableSuggestions: true,
          textCapitalization: TextCapitalization.none,
          // Callback cuando se presiona "Next" en el teclado
          onFieldSubmitted: onFieldSubmitted,
          // Callback alternativo
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            labelText: 'Email Address',
            hintText: 'example@domain.com',
            helperText: 'We\'ll never share your email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: Icon(
              Icons.email_outlined,
              color: isLoading ? Colors.grey.shade400 : null,
            ),
            filled: true,
            fillColor: isLoading
                ? Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.1)
                : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
          ),
          // Validación mejorada con FormValidators
          validator: FormValidators.validateEmail,
        );
      },
    );
  }
}
