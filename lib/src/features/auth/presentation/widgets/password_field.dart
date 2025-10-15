import 'package:flutter/material.dart';
import '../../../../core/utils/form_validators.dart';

/// Widget de campo de contraseña con validación avanzada e indicador de fortaleza
/// Siguiendo el principio de Single Responsibility (SOLID)
class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final bool showStrengthIndicator;
  final String? labelText;
  final String? hintText;

  const PasswordField({
    super.key,
    required this.controller,
    this.focusNode,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.showStrengthIndicator = true,
    this.labelText,
    this.hintText,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> 
    with SingleTickerProviderStateMixin {
  bool _isPasswordObscured = true;
  double _passwordStrength = 0.0;
  late AnimationController _strengthAnimationController;
  late Animation<double> _strengthAnimation;

  @override
  void initState() {
    super.initState();
    _strengthAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _strengthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _strengthAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Listener para calcular fortaleza en tiempo real
    widget.controller.addListener(_updatePasswordStrength);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updatePasswordStrength);
    _strengthAnimationController.dispose();
    super.dispose();
  }

  void _updatePasswordStrength() {
    final newStrength = FormValidators.getPasswordStrength(widget.controller.text);
    if (_passwordStrength != newStrength) {
      setState(() {
        _passwordStrength = newStrength;
      });
      _strengthAnimationController.forward(from: 0.0);
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: _isPasswordObscured,
          textInputAction: TextInputAction.done,
          // Callback cuando se presiona "Done" en el teclado
          onFieldSubmitted: widget.onFieldSubmitted,
          // Callback alternativo
          onEditingComplete: widget.onEditingComplete,
          decoration: InputDecoration(
            labelText: widget.labelText ?? 'Password',
            hintText: widget.hintText ?? 'Enter your password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.lock_outline),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
            suffixIcon: IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: animation,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                child: Icon(
                  _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                  key: ValueKey<bool>(_isPasswordObscured),
                ),
              ),
              onPressed: _togglePasswordVisibility,
              tooltip: _isPasswordObscured ? 'Show password' : 'Hide password',
            ),
          ),
          // Validación mejorada con FormValidators
          validator: FormValidators.validatePassword,
        ),
        // Indicador de fortaleza de contraseña
        if (widget.showStrengthIndicator && widget.controller.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: AnimatedBuilder(
              animation: _strengthAnimation,
              builder: (context, child) {
                final strengthInfo = FormValidators.getPasswordStrengthInfo(_passwordStrength);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Barra de progreso
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: _passwordStrength * _strengthAnimation.value,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(strengthInfo.colorValue),
                        ),
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Etiqueta de fortaleza
                    Text(
                      'Password strength: ${strengthInfo.label}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(strengthInfo.colorValue),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }
}
