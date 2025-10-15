import 'package:flutter/material.dart';
import 'src/core/theme/app_theme.dart';
import 'src/features/auth/presentation/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interactive Login',
      
      // Tema claro
      theme: AppTheme.lightTheme,
      
      // Tema oscuro
      darkTheme: AppTheme.darkTheme,
      
      // Modo de tema: sigue la configuración del sistema
      themeMode: ThemeMode.system,
      
      home: const LoginScreen(),
    );
  }
}
