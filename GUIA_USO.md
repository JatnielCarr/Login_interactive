# 🚀 Interactive Login - Guía de Uso

## 📋 Requisitos Previos

- Flutter SDK instalado (versión 3.9.2 o superior)
- Editor de código (VS Code, Android Studio, etc.)
- Emulador o dispositivo físico

## 🛠️ Instalación

1. **Instalar dependencias:**
```bash
flutter pub get
```

2. **Agregar imagen del logo:**
   - Coloca una imagen llamada `logo_app.png` en: `assets/images/`
   - Si no tienes una imagen, la app mostrará un ícono de fallback con gradiente

## ▶️ Ejecutar la Aplicación

```bash
flutter run
```

## 🔐 Credenciales de Prueba

La aplicación incluye **4 usuarios de demostración**. Puedes usar cualquiera de estos:

| Email | Password | Descripción |
|-------|----------|-------------|
| `test@test.com` | `123456` | Usuario de prueba básico |
| `admin@admin.com` | `admin123` | Usuario administrador |
| `user@example.com` | `pass123` | Usuario ejemplo |
| `demo@demo.com` | `demo123` | Usuario demo |

**Nota:** Estas credenciales están hardcodeadas solo para demostración. En producción, se conectarían a una API real.

## ✨ Características Implementadas

### 1. Validación Avanzada
- ✅ Email con RegEx completo
- ✅ Password con letras y números obligatorios
- ✅ Mensajes de error descriptivos

### 2. Foco Automático
- ✅ Presiona Enter en email → va a password
- ✅ Presiona Enter en password → ejecuta login
- ✅ El teclado se oculta automáticamente

### 3. Estados de Login
- ✅ **Inicial:** Formulario listo para usar
- ✅ **Cargando:** Botón deshabilitado con spinner
- ✅ **Éxito:** SnackBar verde con mensaje de éxito
- ✅ **Error:** SnackBar rojo con mensaje de error

### 4. Componentes Reutilizables
- ✅ EmailField
- ✅ PasswordField
- ✅ RememberMeCheckbox
- ✅ LoginButton
- ✅ AppLogo

### 5. Theming Centralizado
- ✅ Colores consistentes
- ✅ Bordes redondeados
- ✅ Espaciado uniforme
- ✅ Material Design 3

## 🎯 Funcionalidades Interactivas

### Toggle de Visibilidad de Password
- Toca el ícono de ojo para mostrar/ocultar la contraseña

### Remember Me
- Marca el checkbox para recordar la sesión
- El estado se mantiene durante todo el flujo de login

### Forgot Password
- Botón placeholder para futura implementación

## 🧪 Probar Diferentes Escenarios

### Login Exitoso
Prueba con cualquiera de estos usuarios:
1. Email: `test@test.com` / Password: `123456`
2. Email: `admin@admin.com` / Password: `admin123`
3. Email: `user@example.com` / Password: `pass123`
4. Email: `demo@demo.com` / Password: `demo123`
5. Presiona Login
6. Verás SnackBar verde de éxito

### Login Fallido - Credenciales Incorrectas
1. Email: `test@test.com`
2. Password: `wrongpass` (incorrecta)
3. Presiona Login
4. Verás SnackBar rojo: "Contraseña incorrecta"

### Login Fallido - Usuario No Existe
1. Email: `noexiste@email.com`
2. Password: `cualquiera`
3. Presiona Login
4. Verás SnackBar rojo: "Usuario no encontrado"

### Validación de Email
Prueba estos emails para ver errores:
- `invalido` → "Please enter a valid email address"
- `` (vacío) → "Please enter your email"
- `test@` → "Please enter a valid email address"

### Validación de Password
Prueba estos passwords para ver errores:
- `abc` → "Password must be at least 6 characters"
- `123456` → ✅ (solo números pero 6 caracteres)
- `abcdef` → "Password must contain letters and numbers"
- `` (vacío) → "Please enter your password"

## 📱 Navegación por Teclado

1. **Tab / Next:** Mueve el foco entre campos
2. **Enter en Email:** Va al campo de password
3. **Enter en Password:** Ejecuta el login

## 🎨 Personalización

### Cambiar Colores del Tema

Edita `lib/main.dart`:

```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: const Color(0XFF0E1534), // ← Cambia este color
  brightness: Brightness.light,
),
```

### Cambiar Tamaño del Logo

Edita `lib/src/features/auth/presentation/screens/login_screen.dart`:

```dart
const Center(child: AppLogo(size: 180)), // ← Cambia el tamaño
```

### Modificar Tiempo de Simulación de Login

Edita `lib/src/features/auth/application/login_cubit.dart`:

```dart
await Future.delayed(const Duration(seconds: 2)); // ← Cambia la duración
```

## 🔧 Estructura del Proyecto

```
lib/
├── main.dart                              # Punto de entrada y theming
└── src/
    └── features/
        └── auth/
            ├── application/               # Lógica de negocio
            │   ├── login_cubit.dart      # Gestión de estado
            │   └── login_state.dart      # Estados del login
            └── presentation/              # UI
                ├── screens/
                │   └── login_screen.dart # Pantalla principal
                └── widgets/               # Componentes reutilizables
                    ├── app_logo.dart
                    ├── email_field.dart
                    ├── password_field.dart
                    ├── remember_me_checkbox.dart
                    └── login_button.dart
```

## 📚 Tecnologías Utilizadas

- **Flutter:** Framework UI
- **flutter_bloc:** Gestión de estado
- **Material Design 3:** Sistema de diseño

## 🐛 Troubleshooting

### La imagen del logo no aparece
- Verifica que `logo_app.png` esté en `assets/images/`
- Ejecuta `flutter pub get` después de agregar la imagen
- Reinicia la app con hot restart (R mayúscula)

### Errores de compilación
```bash
flutter clean
flutter pub get
flutter run
```

### El botón no responde
- Verifica que el formulario esté validado
- Asegúrate de no estar en estado de loading

## 💡 Tips de Uso

1. **Desarrollo rápido:** Usa Hot Reload (r) para ver cambios
2. **Reset completo:** Usa Hot Restart (R) si algo no funciona
3. **Ver logs:** Observa la consola para mensajes de debug
4. **Testear validaciones:** Prueba con diferentes inputs

## 📞 Contacto y Soporte

Si tienes preguntas o encuentras bugs, revisa:
- El archivo `DESAFIOS_COMPLETADOS.md` para detalles técnicos
- La documentación de Flutter: https://flutter.dev/docs

---

¡Disfruta explorando la aplicación! 🎉
