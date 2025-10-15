import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/login_cubit.dart';
import '../../application/login_state.dart';
import '../widgets/app_logo.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/remember_me_checkbox.dart';
import '../widgets/login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          elevation: 0,
        ),
        body: const SingleChildScrollView(
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with TickerProviderStateMixin {
  // Form key para validación
  final _formKey = GlobalKey<FormState>();
  
  // Controllers para los campos
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // FocusNodes para gestión avanzada del foco
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  
  // Estado de validación automática
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  
  // Controlador de animación para transiciones
  late AnimationController _formAnimationController;
  late Animation<double> _formFadeAnimation;
  late Animation<Offset> _formSlideAnimation;

  @override
  void initState() {
    super.initState();
    
    // Configurar animaciones de entrada del formulario
    _formAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _formFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _formAnimationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    
    _formSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _formAnimationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );
    
    // Iniciar animación
    _formAnimationController.forward();
    
    // Listeners para debugging (opcional en producción)
    _emailFocusNode.addListener(_onEmailFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
  }

  @override
  void dispose() {
    // Limpiar recursos
    _formAnimationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  // Callbacks de cambio de foco para debugging
  void _onEmailFocusChange() {
    debugPrint('Email field focus: ${_emailFocusNode.hasFocus}');
  }

  void _onPasswordFocusChange() {
    debugPrint('Password field focus: ${_passwordFocusNode.hasFocus}');
  }

  /// Función centralizada de envío del formulario
  /// Siguiendo el principio de Don't Repeat Yourself (DRY)
  void _submitForm() {
    // Quitar el foco del teclado para ocultar el teclado
    FocusScope.of(context).unfocus();

    // Validar el formulario
    if (_formKey.currentState!.validate()) {
      // Si es válido, llamar al Cubit para procesar el login
      context.read<LoginCubit>().login(
            _emailController.text.trim(),
            _passwordController.text,
          );
    } else {
      // Si hay errores, activar autovalidación para mostrar errores en tiempo real
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
      
      // Mostrar feedback visual
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text('Please fix the errors in the form'),
              ),
            ],
          ),
          backgroundColor: Colors.orange.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// Manejador cuando se completa el campo de email (presiona Next)
  void _onEmailFieldSubmitted(String value) {
    // Mover el foco al campo de contraseña con animación suave
    _passwordFocusNode.requestFocus();
  }

  /// Manejador cuando se completa el campo de contraseña (presiona Done)
  void _onPasswordFieldSubmitted(String value) {
    // Intentar enviar el formulario
    _submitForm();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 12),
                  Text('Login successful!'),
                ],
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(child: Text(state.error)),
                ],
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              duration: const Duration(seconds: 4),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: FadeTransition(
            opacity: _formFadeAnimation,
            child: SlideTransition(
              position: _formSlideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  // Logo con animación Hero
                  const Center(child: AppLogo(size: 180)),
                  const SizedBox(height: 40),
                  // Título
                  Text(
                    'Welcome Back!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to continue',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // Campo de Email con gestión de foco mejorada
                  EmailField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    autofocus: true,
                    onFieldSubmitted: _onEmailFieldSubmitted,
                  ),
                  const SizedBox(height: 16),
                  // Campo de Contraseña con indicador de fortaleza
                  PasswordField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    onFieldSubmitted: _onPasswordFieldSubmitted,
                    showStrengthIndicator: true,
                  ),
                  const SizedBox(height: 12),
                  // Checkbox Remember Me
                  const RememberMeCheckbox(),
                  const SizedBox(height: 24),
                  // Botón de Login con función refactorizada
                  LoginButton(onPressed: _submitForm),
                  const SizedBox(height: 16),
                  // Texto de ayuda
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Navegar a pantalla de recuperación de contraseña
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Forgot password feature coming soon!'),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
