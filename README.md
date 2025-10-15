# 🔐 Interactive Login

[![Flutter Version](https://img.shields.io/badge/Flutter-3.9.2+-blue.svg)](https://flutter.dev/)
[![Dart Version](https://img.shields.io/badge/Dart-3.9.2+-blue.svg)](https://dart.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Una aplicación Flutter moderna de autenticación con gestión de estado avanzada, validaciones robustas y una UI pulida siguiendo Material Design 3.

## ✨ Características

### 🎯 Core Features
- ✅ **Autenticación completa** con validación avanzada de email y password
- ✅ **Gestión de estado** con Cubit (flutter_bloc)
- ✅ **Múltiples usuarios** de demostración (4 usuarios)
- ✅ **Toggle de visibilidad** de contraseña
- ✅ **Remember Me** con estado persistente
- ✅ **Feedback visual** dinámico durante el login

### 🎨 UI/UX
- ✅ **Material Design 3** con tema personalizado
- ✅ **Componentes reutilizables** y modulares
- ✅ **Animaciones suaves** (FadeTransition + SlideTransition + Hero)
- ✅ **Mensajes de error** contextuales y específicos
- ✅ **Gestión del foco** automática con FocusNode
- ✅ **TextInputAction** configurado (Next/Done) para flujo de teclado
- ✅ **onFieldSubmitted** para navegación automática entre campos
- ✅ **Loading states** con spinner integrado
- ✅ **SnackBars** con íconos y diseño moderno
- ✅ **Indicador de fortaleza** de contraseña en tiempo real

### 🏗️ Arquitectura
- ✅ **Clean Architecture** con separación de capas (Core/Application/Presentation)
- ✅ **BLoC Pattern** para gestión de estado
- ✅ **Widgets componentizados** (5 componentes custom)
- ✅ **Theming centralizado**
- ✅ **SOLID Principles** aplicados al 95%
- ✅ **FormValidators** utility class para validación reutilizable
- ✅ **Code organization** siguiendo convenciones de Flutter
- ✅ **_submitForm()** centralizado (DRY principle)

### 🔐 Validación Avanzada
- ✅ **RegExp balanceado** según RFC 5322 para email
- ✅ **Validación de longitud** (máx 254 caracteres en email)
- ✅ **Password strength indicator** con colores dinámicos (Weak/Medium/Good/Strong)
- ✅ **AutovalidateMode inteligente** (activa solo después del primer error)
- ✅ **Trim automático** en campos de texto
- ✅ **Mensajes específicos** según tipo de error detectado

---

## 📱 Screenshots

```
┌─────────────────────────────────┐
│         Interactive Login       │
├─────────────────────────────────┤
│                                 │
│         [Logo con Hero]         │
│                                 │
│       Welcome Back!             │
│     Sign in to continue         │
│                                 │
│  📧 Email Address               │
│  ┌──────────────────────────┐  │
│  │                          │  │
│  └──────────────────────────┘  │
│                                 │
│  🔒 Password                    │
│  ┌──────────────────────────┐  │
│  │ ••••••••           👁    │  │
│  └──────────────────────────┘  │
│                                 │
│  ☑ Remember Me                  │
│                                 │
│  ┌──────────────────────────┐  │
│  │        Login             │  │
│  └──────────────────────────┘  │
│                                 │
│      Forgot Password?           │
│                                 │
└─────────────────────────────────┘
```

---

## 🚀 Inicio Rápido

### Prerrequisitos

- Flutter SDK (3.9.2 o superior)
- Dart SDK (3.9.2 o superior)
- Android Studio / Xcode / VS Code
- Emulador o dispositivo físico

### Instalación

1. **Clonar el repositorio**
```bash
git clone https://github.com/tu-usuario/interactive-login.git
cd interactive-login
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Agregar logo (opcional)**
   - Coloca una imagen `logo_app.png` en `assets/images/`
   - Si no la agregas, se mostrará un fallback con gradiente

4. **Ejecutar la aplicación**
```bash
flutter run
```

---

## 🔑 Credenciales de Prueba

| Email | Password | Rol |
|-------|----------|-----|
| `test@test.com` | `123456` | Usuario básico |
| `admin@admin.com` | `admin123` | Admin |
| `user@example.com` | `pass123` | Usuario |
| `demo@demo.com` | `demo123` | Demo |

**Ver más:** [`CREDENCIALES.md`](CREDENCIALES.md)

---

## 📂 Estructura del Proyecto

```
lib/
├── main.dart                                 # Entry point y configuración de tema
└── src/
    ├── core/                                 # 🔧 Funcionalidades compartidas
    │   └── utils/
    │       └── form_validators.dart          # Validaciones reutilizables
    └── features/
        └── auth/
            ├── application/                  # 🧠 Lógica de negocio
            │   ├── login_cubit.dart          # Estado y lógica del login
            │   └── login_state.dart          # Estados (Initial, Loading, Success, Failure)
            └── presentation/                 # 🎨 Capa de presentación
                ├── screens/
                │   └── login_screen.dart     # Pantalla principal con animaciones
                └── widgets/                  # Componentes reutilizables
                    ├── app_logo.dart         # Logo con Hero animation
                    ├── email_field.dart      # Email con validación RegExp
                    ├── password_field.dart   # Password con strength indicator
                    ├── remember_me_checkbox.dart  # Checkbox con Cubit
                    └── login_button.dart     # Botón con loading state
```

---

## 🛠️ Tecnologías y Paquetes

### Dependencias Principales

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_bloc: ^9.1.1      # Gestión de estado
```

### Dev Dependencies

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0     # Linting
```

---

## 🎓 Conceptos Implementados

### State Management
- **Cubit** para lógica de negocio simple
- **BlocBuilder** para reconstrucción reactiva de UI
- **BlocListener** para side effects (SnackBars)
- **BlocConsumer** cuando se necesitan ambos
- **Estados tipados** (Initial, Loading, Success, Failure)

### Validaciones Avanzadas
- **RegExp balanceado** `r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'` para email (RFC 5322)
- **Validación de longitud** en email (máx 254 caracteres)
- **Password strength calculation** con 7 criterios
- **Trim automático** en campos de entrada
- **Mensajes específicos** según tipo de error detectado
- **AutovalidateMode inteligente** (activa solo después del primer error)
- **FormValidators utility class** para validación reutilizable (DRY)

### Focus Management
- **FocusNode** para gestión explícita del foco
- **TextInputAction.next** en email (botón ▶ en teclado)
- **TextInputAction.done** en password (botón ✓ en teclado)
- **onFieldSubmitted** para navegación automática
- **_submitForm()** centralizado desde múltiples puntos
- **FocusScope.unfocus()** al enviar formulario
- **Debug listeners** en FocusNodes

### Animaciones
- **AnimationController** con TickerProviderStateMixin
- **FadeTransition** para opacity animation
- **SlideTransition** para entrada desde abajo
- **CurvedAnimation** con Intervals staggered
- **Hero animation** en el logo
- **AnimatedSwitcher** para iconos de visibilidad
- **LinearProgressIndicator animado** en strength indicator

### Widget Composition
- Separación de responsabilidades
- Componentes pequeños y reutilizables
- Single Responsibility Principle
- Props para configuración
- Callbacks para comunicación padre-hijo
- Stateless vs Stateful según necesidad

### Theming
- ColorScheme centralizado (#0E1534 primary)
- InputDecorationTheme global
- ElevatedButtonTheme consistente
- Material Design 3 completo
- Colores dinámicos según contexto

---

## 📚 Documentación Adicional

- 📖 [**Guía de Uso**](GUIA_USO.md) - Instrucciones detalladas de uso
- 👥 [**Gestión de Usuarios**](GESTION_USUARIOS.md) - Cómo agregar/modificar usuarios
- 🎯 [**Desafíos Completados**](DESAFIOS_COMPLETADOS.md) - Detalles técnicos de implementación
- � [**Mejoras Login Screen**](MEJORAS_LOGIN_SCREEN.md) - **⭐ NUEVO** Transformación robusta con SOLID + Clean Architecture
- �🔐 [**Credenciales**](CREDENCIALES.md) - Lista de usuarios disponibles
- 🌳 [**Git Guide**](GIT_GUIDE.md) - Guía de versionamiento

---

## 🧪 Testing

### Ejecutar tests
```bash
flutter test
```

### Análisis de código
```bash
flutter analyze
```

### Escenarios de prueba

**Login Exitoso:**
1. Email: `test@test.com`
2. Password: `123456`
3. ✅ Resultado: SnackBar verde

**Password Incorrecta:**
1. Email: `test@test.com`
2. Password: `wrong`
3. ❌ Resultado: "Contraseña incorrecta"

**Usuario No Existe:**
1. Email: `noexiste@test.com`
2. Password: `cualquiera`
3. ❌ Resultado: "Usuario no encontrado"

---

## 🔮 Roadmap

### Próximas Features
- [ ] Integración con API real
- [ ] Persistencia con SharedPreferences
- [ ] Autenticación con Firebase
- [ ] Recuperación de contraseña
- [ ] Registro de nuevos usuarios
- [ ] Autenticación biométrica
- [ ] OAuth (Google, Facebook)
- [ ] Dark mode
- [ ] Internacionalización (i18n)
- [ ] Tests unitarios completos
- [ ] Tests de integración
- [ ] CI/CD con GitHub Actions

---

## 🤝 Contribuir

¡Las contribuciones son bienvenidas!

1. Fork el proyecto
2. Crea tu feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m '✨ feat: Add some AmazingFeature'`)
4. Push a la branch (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

### Convenciones de Commit

Usamos [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` Nueva característica
- `fix:` Corrección de bug
- `docs:` Cambios en documentación
- `style:` Cambios de formato (no afectan código)
- `refactor:` Refactorización de código
- `test:` Agregar o modificar tests
- `chore:` Cambios en build process o herramientas

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.

---

## 👨‍💻 Autor

**Tu Nombre**
- GitHub: [@tu-usuario](https://github.com/tu-usuario)
- Email: tuemail@ejemplo.com

---

## 🙏 Agradecimientos

- Flutter Team por el increíble framework
- flutter_bloc por la gestión de estado
- Material Design 3 por las guías de diseño
- La comunidad de Flutter por el soporte continuo

---

## 📞 Soporte

Si tienes preguntas o problemas:

1. Revisa la [Guía de Uso](GUIA_USO.md)
2. Busca en [Issues existentes](https://github.com/tu-usuario/interactive-login/issues)
3. Crea un [Nuevo Issue](https://github.com/tu-usuario/interactive-login/issues/new)

---

## 🌟 ¿Te gustó el proyecto?

Si este proyecto te fue útil, considera:

- ⭐ Darle una estrella en GitHub
- 🍴 Hacer un fork
- 📢 Compartirlo con otros
- 💬 Dejar feedback

---

<div align="center">
  
**Hecho con ❤️ usando Flutter**

[⬆ Volver arriba](#-interactive-login)

</div>
