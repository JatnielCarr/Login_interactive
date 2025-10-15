import 'package:flutter/material.dart';

/// Widget reutilizable de campo de texto personalizado
/// Siguiendo principios SOLID (Single Responsibility, Open/Closed)
/// Encapsula toda la lógica de un TextFormField configurable
class CustomTextFormField extends StatefulWidget {
  // Configuración básica
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? helperText;
  
  // Validación
  final String? Function(String?)? validator;
  
  // Tipo de campo
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  
  // Iconos
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  
  // Comportamiento
  final bool enabled;
  final bool autofocus;
  final bool autocorrect;
  final bool enableSuggestions;
  final TextCapitalization textCapitalization;
  
  // Callbacks
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  
  // Focus
  final FocusNode? focusNode;
  
  // Estilo
  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.helperText,
    this.validator,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.textCapitalization = TextCapitalization.none,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onChanged,
    this.focusNode,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    _isPasswordObscured = widget.isPassword;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      obscureText: widget.isPassword && _isPasswordObscured,
      keyboardType: widget.keyboardType ?? _getDefaultKeyboardType(),
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      textCapitalization: widget.textCapitalization,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      
      // Callbacks
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      
      // Decoración
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        helperText: widget.helperText,
        
        // Ícono prefijo
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: widget.enabled
                    ? theme.inputDecorationTheme.prefixIconColor
                    : Colors.grey.shade400,
              )
            : null,
        
        // Ícono sufijo (toggle para password o custom)
        suffixIcon: _buildSuffixIcon(theme),
        
        // Aplicar tema global (ya definido en app_theme.dart)
        // No necesitamos redefinir border, fillColor, etc.
      ),
      
      // Validación
      validator: widget.validator,
    );
  }

  /// Determina el tipo de teclado por defecto según el tipo de campo
  TextInputType _getDefaultKeyboardType() {
    if (widget.isPassword) {
      return TextInputType.visiblePassword;
    }
    return TextInputType.text;
  }

  /// Construye el ícono de sufijo apropiado
  Widget? _buildSuffixIcon(ThemeData theme) {
    // Si hay un suffixIcon custom, usarlo
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }
    
    // Si es campo de password, mostrar toggle de visibilidad
    if (widget.isPassword) {
      return IconButton(
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
            color: widget.enabled
                ? theme.inputDecorationTheme.suffixIconColor
                : Colors.grey.shade400,
          ),
        ),
        onPressed: widget.enabled ? _togglePasswordVisibility : null,
        tooltip: _isPasswordObscured ? 'Show password' : 'Hide password',
      );
    }
    
    return null;
  }
}

