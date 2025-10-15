# 🔐 Interactive Login

[![Flutter Version](https://img.shields.io/badge/Flutter-3.9.2+-blue.svg)](https://flutter.dev/)
[![Dart Version](https://img.shields.io/badge/Dart-3.9.2+-blue.svg)](https://dart.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Una aplicación Flutter moderna de autenticación con gestión de estado avanzada, validaciones robustas y una UI pulida siguiendo Material Design 3.

## ✨ Características

### 🎯 Core Features
- ✅ **Autenticación completa** con validación avanzada de email y password
- ✅ **Gestión de estado** con Cubit (flutter_bloc)
- ✅ **Múltiples usuarios** de demostración
- ✅ **Toggle de visibilidad** de contraseña
- ✅ **Remember Me** con estado persistente
- ✅ **Feedback visual** dinámico durante el login

### 🎨 UI/UX
- ✅ **Material Design 3** con tema personalizado
- ✅ **Componentes reutilizables** y modulares
- ✅ **Animaciones** (Hero animation en logo)
- ✅ **Mensajes de error** contextuales y específicos
- ✅ **Foco automático** entre campos
- ✅ **Loading states** con spinner integrado
- ✅ **SnackBars** con íconos y diseño moderno

### 🏗️ Arquitectura
- ✅ **Clean Architecture** con separación de capas
- ✅ **BLoC Pattern** para gestión de estado
- ✅ **Widgets componentizados** (5 componentes custom)
- ✅ **Theming centralizado**
- ✅ **SOLID Principles** aplicados
- ✅ **Code organization** siguiendo convenciones de Flutter

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
├── main.dart                              # Entry point y configuración de tema
└── src/
    └── features/
        └── auth/
            ├── application/               # Lógica de negocio
            │   ├── login_cubit.dart      # Estado y lógica del login
            │   └── login_state.dart      # Estados (Initial, Loading, Success, Failure)
            └── presentation/              # Capa de presentación
                ├── screens/
                │   └── login_screen.dart # Pantalla principal
                └── widgets/               # Componentes reutilizables
                    ├── app_logo.dart
                    ├── email_field.dart
                    ├── password_field.dart
                    ├── remember_me_checkbox.dart
                    └── login_button.dart
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

### Validaciones
- **RegEx avanzado** para email
- **Validación de contenido** (letras + números en password)
- **Mensajes específicos** según tipo de error
- **Validación en tiempo real** al enviar formulario

### Widget Composition
- Separación de responsabilidades
- Componentes pequeños y reutilizables
- Single Responsibility Principle
- Props para configuración

### Theming
- ColorScheme centralizado
- InputDecorationTheme global
- ElevatedButtonTheme consistente
- Material Design 3 completo

---

## 📚 Documentación Adicional

- 📖 [**Guía de Uso**](GUIA_USO.md) - Instrucciones detalladas de uso
- 👥 [**Gestión de Usuarios**](GESTION_USUARIOS.md) - Cómo agregar/modificar usuarios
- 🎯 [**Desafíos Completados**](DESAFIOS_COMPLETADOS.md) - Detalles técnicos de implementación
- 🔐 [**Credenciales**](CREDENCIALES.md) - Lista de usuarios disponibles
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
