# 🔑 CREDENCIALES DE ACCESO

## ⚠️ ACTUALIZACIÓN IMPORTANTE

**Fecha:** 15 de octubre de 2025  
**Versión:** 2.0 - Refactorización Sealed Class

> Las credenciales del sistema han sido actualizadas. Ahora solo existe **UN** usuario de prueba con credenciales específicas.

---

## ✅ Usuario Actual

```
┌─────────────────────────────────────────────────────┐
│             USUARIO DE PRUEBA PRINCIPAL             │
├─────────────────────────────────────────────────────┤
│ Email:    test@javerage.com                         │
│ Password: 5ecret4                                   │
│ Uso:      Usuario único de demostración            │
└─────────────────────────────────────────────────────┘
```

### 📋 Detalles

| Campo | Valor |
|-------|-------|
| **Email** | `test@javerage.com` |
| **Password** | `5ecret4` |
| **Tipo** | Usuario de prueba |
| **Estado** | ✅ Activo |

---

## 🚀 Cómo Usar

### ✅ **Login Exitoso**

**Pasos:**
1. Abre la aplicación
2. Ingresa:
   - Email: `test@javerage.com`
   - Password: `5ecret4`
3. Presiona "Login" o tecla Enter/Done

**Resultado esperado:**
- ⏳ Spinner durante 2 segundos
- ✅ SnackBar verde: "Login successful!"
- 🧹 Campos se limpian automáticamente
- 🔄 Validación se resetea
- 📍 (Futuro) Navegación a pantalla principal

**Screenshot esperado:**
```
┌──────────────────────────────────┐
│   ✅ Login successful!           │  ← SnackBar verde
└──────────────────────────────────┘
```

---

### ❌ **Login Fallido**

**Pasos:**
1. Abre la aplicación
2. Ingresa credenciales incorrectas:
   - Email: `cualquier@email.com`
   - Password: `cualquierpass`
3. Presiona "Login"

**Resultado esperado:**
- ⏳ Spinner durante 2 segundos
- 🔴 AlertDialog aparece con:

```
╔════════════════════════════════════╗
║        🔴 (ícono error)            ║
║                                    ║
║    Error de Autenticación          ║
║    ────────────────────            ║
║                                    ║
║  Credenciales inválidas.           ║
║  Inténtalo de nuevo.               ║
║                                    ║
║            [Aceptar]               ║
╚════════════════════════════════════╝
```

- Los campos NO se limpian (puedes corregir)

---

## 🔍 Casos de Prueba

### Caso 1: Email Correcto + Password Correcta ✅
```
Email: test@javerage.com
Password: 5ecret4
→ LOGIN EXITOSO
```

### Caso 2: Email Correcto + Password Incorrecta ❌
```
Email: test@javerage.com
Password: incorrecta
→ "Credenciales inválidas. Inténtalo de nuevo."
```

### Caso 3: Email Incorrecto + Cualquier Password ❌
```
Email: noexiste@email.com
Password: cualquiera
→ "Credenciales inválidas. Inténtalo de nuevo."
```

### Caso 4: Validación de Formato ⚠️
```
Email: emailsinformato
Password: 5ecret4
→ Error de validación: "Email must contain @"
(No llega al Cubit)
```

---

## 🔐 Seguridad

### ¿Por Qué Un Solo Usuario?

**Antes:**
```dart
// Múltiples usuarios con mensajes específicos
if (user exists && password wrong) → "Contraseña incorrecta"
if (user not exists) → "Usuario no encontrado"
```
❌ **Problema:** Revela información (enumeración de usuarios)

**Ahora:**
```dart
// Un solo usuario con mensaje genérico
if (credentials invalid) → "Credenciales inválidas"
```
✅ **Beneficio:** No revela si el email existe o no

---

## 📝 Cambios Realizados

### Desde Versión 1.0

| Aspecto | Antes (v1.0) | Ahora (v2.0) |
|---------|--------------|--------------|
| **Usuarios** | 4 usuarios diferentes | 1 usuario específico |
| **Email** | test@test.com | test@javerage.com |
| **Password** | 123456 | 5ecret4 |
| **Mensaje Error** | 2 mensajes diferentes | 1 mensaje genérico |
| **Feedback Error** | SnackBar roja | AlertDialog modal |
| **Limpieza Campos** | ❌ No | ✅ Sí |

### Usuarios Anteriores (DESACTIVADOS)

~~test@test.com~~ → Ya no funciona  
~~admin@admin.com~~ → Ya no funciona  
~~user@example.com~~ → Ya no funciona  
~~demo@demo.com~~ → Ya no funciona  

**Usa:** `test@javerage.com` / `5ecret4`

---

## 🛠️ Modificar Credenciales

Si necesitas cambiar las credenciales de prueba:

### Archivo a Editar
`lib/src/features/auth/application/login_cubit.dart`

### Busca (línea ~13):
```dart
static const String _validEmail = 'test@javerage.com';
static const String _validPassword = '5ecret4';
```

### Reemplaza por:
```dart
static const String _validEmail = 'tuemail@ejemplo.com';
static const String _validPassword = 'tupassword';
```

### Guarda y Recarga
```bash
# Hot reload
r

# O hot restart
R
```

---

## 🎯 Tips de Uso

### ✅ **Recomendaciones**

1. **Usa autofocus**: El campo de email tiene foco automático
2. **Navega con teclado**: Presiona "Next" → va a password
3. **Submit rápido**: Presiona "Done" → envía formulario
4. **Fortaleza visible**: Observa el indicador de contraseña
5. **Remember Me**: Marca para simular sesión persistente

### 🔒 **Validaciones Activas**

- ✅ Email debe tener formato válido (RegExp)
- ✅ Email máximo 254 caracteres
- ✅ Password mínimo 6 caracteres
- ✅ Password debe tener letras Y números
- ✅ Campos requeridos (no vacíos)

---

## 📚 Documentación Relacionada

| Archivo | Descripción |
|---------|-------------|
| `REFACTORIZACION_LOGIN_CUBIT.md` | Detalles técnicos de la refactorización |
| `GESTION_USUARIOS.md` | Guía para gestión de usuarios (futuro) |
| `GUIA_USO.md` | Guía completa de uso de la aplicación |
| `MEJORAS_LOGIN_SCREEN.md` | Mejoras en validación y UX |

---

## 🚀 Próximos Pasos

Una vez que el login sea exitoso:

1. ✅ SnackBar de confirmación
2. ✅ Campos se limpian
3. 🔄 **TODO:** Navegar a `HomeScreen`
4. 🔄 **TODO:** Guardar token de sesión
5. 🔄 **TODO:** Implementar "Remember Me" funcional
6. 🔄 **TODO:** Conectar con API real

---

## ❓ FAQ

### ¿Puedo agregar más usuarios?

Sí, pero tendrías que modificar `login_cubit.dart` para usar un `Map` nuevamente:

```dart
static final Map<String, String> _validUsers = {
  'test@javerage.com': '5ecret4',
  'otro@email.com': 'otrapass',
};
```

Luego ajustar la lógica de validación.

### ¿Las credenciales son case-sensitive?

**Email:** No (se normaliza automáticamente)  
**Password:** Sí (distingue mayúsculas/minúsculas)

### ¿Cuánto dura el "login"?

**Simulación:** 2 segundos (Future.delayed)  
**Producción:** Dependerá de tu API

---

## 🎓 Para Desarrolladores

### Estructura del Código

```dart
// LoginCubit gestiona la lógica
class LoginCubit extends Cubit<LoginState> {
  Future<void> login(String email, String password) async {
    emit(LoginLoading(...));  // Estado de carga
    await Future.delayed(2s);  // Simula red
    
    if (valid) {
      emit(LoginSuccess(...));  // ✅ Éxito
    } else {
      emit(LoginFailure(...));  // ❌ Error
    }
  }
}
```

### Estados Disponibles

```dart
sealed class LoginState {  // ← Sealed para type-safety
  LoginInitial    // Estado inicial
  LoginLoading    // Durante autenticación
  LoginSuccess    // Login exitoso
  LoginFailure    // Error con mensaje
}
```

---

**⚠️ IMPORTANTE:** Estas credenciales son solo para demostración.  
**NUNCA** uses credenciales hardcoded en producción.

---

✅ **¡Listo para probar!**

Ejecuta `flutter run` e ingresa:
- Email: `test@javerage.com`
- Password: `5ecret4`

🎉 ¡Disfruta explorando la aplicación!
