/// Clase de utilidades para validación de formularios
/// Siguiendo el principio de Single Responsibility (SOLID)
class FormValidators {
  FormValidators._(); // Constructor privado para prevenir instanciación

  /// Expresión regular balanceada para validación de email según RFC 5322
  /// Verifica:
  /// - Parte local: letras, números, puntos, guiones, etc.
  /// - @ obligatorio
  /// - Dominio: letras, números, puntos, guiones
  /// - Extensión: al menos 2 letras
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// Expresión regular para detectar al menos una letra
  static final RegExp _hasLetterRegex = RegExp(r'[A-Za-z]');

  /// Expresión regular para detectar al menos un número
  static final RegExp _hasNumberRegex = RegExp(r'[0-9]');

  /// Expresión regular para detectar caracteres especiales
  static final RegExp _hasSpecialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  /// Valida un email y retorna un mensaje de error o null si es válido
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }

    // Trim para eliminar espacios al inicio y final
    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      return 'Email address cannot be empty';
    }

    // Validación de longitud razonable
    if (trimmedValue.length > 254) {
      return 'Email address is too long';
    }

    // Validación con RegExp balanceada
    if (!_emailRegex.hasMatch(trimmedValue)) {
      // Mensajes de error más específicos
      if (!trimmedValue.contains('@')) {
        return 'Email must contain @';
      }
      if (trimmedValue.startsWith('@') || trimmedValue.endsWith('@')) {
        return 'Invalid email format';
      }
      if (!trimmedValue.contains('.') || 
          trimmedValue.indexOf('.') < trimmedValue.indexOf('@')) {
        return 'Email must have a valid domain';
      }
      return 'Please enter a valid email address';
    }

    return null; // Email válido
  }

  /// Valida una contraseña y retorna un mensaje de error o null si es válida
  static String? validatePassword(String? value, {
    int minLength = 6,
    bool requireLetters = true,
    bool requireNumbers = true,
    bool requireSpecialChars = false,
  }) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    if (requireLetters && !_hasLetterRegex.hasMatch(value)) {
      return 'Password must contain at least one letter';
    }

    if (requireNumbers && !_hasNumberRegex.hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    if (requireSpecialChars && !_hasSpecialCharRegex.hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null; // Contraseña válida
  }

  /// Calcula la fortaleza de una contraseña (0.0 a 1.0)
  static double getPasswordStrength(String password) {
    if (password.isEmpty) return 0.0;

    double strength = 0.0;

    // Longitud
    if (password.length >= 6) strength += 0.2;
    if (password.length >= 8) strength += 0.1;
    if (password.length >= 12) strength += 0.1;

    // Tiene letras
    if (_hasLetterRegex.hasMatch(password)) strength += 0.2;

    // Tiene números
    if (_hasNumberRegex.hasMatch(password)) strength += 0.2;

    // Tiene caracteres especiales
    if (_hasSpecialCharRegex.hasMatch(password)) strength += 0.1;

    // Tiene mayúsculas y minúsculas
    if (password.contains(RegExp(r'[a-z]')) && 
        password.contains(RegExp(r'[A-Z]'))) {
      strength += 0.1;
    }

    return strength.clamp(0.0, 1.0);
  }

  /// Obtiene el color según la fortaleza de la contraseña
  static ({String label, int colorValue}) getPasswordStrengthInfo(double strength) {
    if (strength < 0.3) {
      return (label: 'Weak', colorValue: 0xFFE53935); // Rojo
    } else if (strength < 0.6) {
      return (label: 'Medium', colorValue: 0xFFFB8C00); // Naranja
    } else if (strength < 0.8) {
      return (label: 'Good', colorValue: 0xFF43A047); // Verde
    } else {
      return (label: 'Strong', colorValue: 0xFF2E7D32); // Verde oscuro
    }
  }

  /// Valida que dos contraseñas coincidan
  static String? validatePasswordMatch(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Valida un nombre (sin números ni caracteres especiales)
  static String? validateName(String? value, {String fieldName = 'Name'}) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length < 2) {
      return '$fieldName must be at least 2 characters';
    }

    if (RegExp(r'[0-9]').hasMatch(trimmedValue)) {
      return '$fieldName cannot contain numbers';
    }

    return null;
  }
}
