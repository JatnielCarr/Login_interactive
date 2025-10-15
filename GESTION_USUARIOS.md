# 👥 Guía de Gestión de Usuarios

## 📋 Usuarios Actuales Disponibles

La aplicación incluye 4 usuarios de demostración:

| # | Email | Password | Descripción |
|---|-------|----------|-------------|
| 1 | `test@test.com` | `123456` | Usuario de prueba básico |
| 2 | `admin@admin.com` | `admin123` | Usuario administrador |
| 3 | `user@example.com` | `pass123` | Usuario ejemplo |
| 4 | `demo@demo.com` | `demo123` | Usuario demo |

---

## ➕ Cómo Agregar Nuevos Usuarios

### Opción 1: Agregar Manualmente al Código

1. **Abre el archivo:** `lib/src/features/auth/application/login_cubit.dart`

2. **Busca la sección de usuarios válidos** (línea ~10-15):
```dart
static final Map<String, String> _validUsers = {
  'test@test.com': '123456',
  'admin@admin.com': 'admin123',
  'user@example.com': 'pass123',
  'demo@demo.com': 'demo123',
};
```

3. **Agrega tu nuevo usuario:**
```dart
static final Map<String, String> _validUsers = {
  'test@test.com': '123456',
  'admin@admin.com': 'admin123',
  'user@example.com': 'pass123',
  'demo@demo.com': 'demo123',
  // ⬇️ Agrega aquí tu nuevo usuario
  'tunombre@email.com': 'tupassword',
  'otro@ejemplo.com': 'pass456',
};
```

4. **Guarda el archivo** y ejecuta Hot Reload (r) o Hot Restart (R)

5. **¡Listo!** Ya puedes usar tus nuevas credenciales

---

## 🔄 Opción 2: Conectar con una API Real

Si quieres conectar con un backend real, modifica el método `login` en `login_cubit.dart`:

### Ejemplo con HTTP:

1. **Agrega la dependencia** en `pubspec.yaml`:
```yaml
dependencies:
  http: ^1.1.0
```

2. **Modifica el método login:**
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> login(String email, String password) async {
  emit(LoginLoading(isRememberMeChecked: state.isRememberMeChecked));
  
  try {
    // Llamada a tu API real
    final response = await http.post(
      Uri.parse('https://tu-api.com/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    
    if (response.statusCode == 200) {
      // Login exitoso
      final data = json.decode(response.body);
      // Aquí puedes guardar el token, etc.
      emit(LoginSuccess(isRememberMeChecked: state.isRememberMeChecked));
    } else if (response.statusCode == 401) {
      // Credenciales incorrectas
      emit(LoginFailure(
        'Credenciales incorrectas',
        isRememberMeChecked: state.isRememberMeChecked,
      ));
    } else {
      // Otro error
      emit(LoginFailure(
        'Error del servidor',
        isRememberMeChecked: state.isRememberMeChecked,
      ));
    }
  } catch (e) {
    emit(LoginFailure(
      'Error de conexión: ${e.toString()}',
      isRememberMeChecked: state.isRememberMeChecked,
    ));
  }
}
```

---

## 🗄️ Opción 3: Usar Base de Datos Local (SQLite)

Para una app móvil con usuarios offline:

1. **Agrega dependencias:**
```yaml
dependencies:
  sqflite: ^2.3.0
  path: ^1.8.3
```

2. **Crea un servicio de base de datos:**
```dart
class DatabaseService {
  Future<bool> validateUser(String email, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty;
  }
  
  Future<void> registerUser(String email, String password) async {
    final db = await database;
    await db.insert('users', {
      'email': email,
      'password': password,
    });
  }
}
```

3. **Úsalo en tu Cubit:**
```dart
Future<void> login(String email, String password) async {
  emit(LoginLoading(isRememberMeChecked: state.isRememberMeChecked));
  
  final dbService = DatabaseService();
  final isValid = await dbService.validateUser(email, password);
  
  if (isValid) {
    emit(LoginSuccess(isRememberMeChecked: state.isRememberMeChecked));
  } else {
    emit(LoginFailure(
      'Credenciales incorrectas',
      isRememberMeChecked: state.isRememberMeChecked,
    ));
  }
}
```

---

## 🔒 Opción 4: Firebase Authentication

Para usar Firebase (recomendado para producción):

1. **Agrega Firebase:**
```yaml
dependencies:
  firebase_core: ^2.24.0
  firebase_auth: ^4.15.0
```

2. **Configura Firebase** en tu proyecto

3. **Modifica el login:**
```dart
import 'package:firebase_auth/firebase_auth.dart';

Future<void> login(String email, String password) async {
  emit(LoginLoading(isRememberMeChecked: state.isRememberMeChecked));
  
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    emit(LoginSuccess(isRememberMeChecked: state.isRememberMeChecked));
  } on FirebaseAuthException catch (e) {
    String message;
    if (e.code == 'user-not-found') {
      message = 'Usuario no encontrado';
    } else if (e.code == 'wrong-password') {
      message = 'Contraseña incorrecta';
    } else {
      message = 'Error al iniciar sesión';
    }
    
    emit(LoginFailure(
      message,
      isRememberMeChecked: state.isRememberMeChecked,
    ));
  }
}
```

---

## 🛡️ Mejores Prácticas de Seguridad

### ⚠️ NO hagas esto en producción:
```dart
// ❌ MAL: Passwords en texto plano
static final Map<String, String> _validUsers = {
  'user@email.com': 'password123',
};
```

### ✅ Haz esto en producción:

1. **Nunca almacenes passwords en texto plano**
2. **Usa hashing** (bcrypt, scrypt, argon2)
3. **Usa HTTPS** para todas las peticiones
4. **Implementa rate limiting** para prevenir brute force
5. **Usa tokens JWT** o similares para sesiones
6. **Implementa refresh tokens**
7. **Valida en el backend**, nunca confíes solo en el frontend

### Ejemplo con hashing (si usas backend Node.js):
```javascript
// Backend (Node.js con bcrypt)
const bcrypt = require('bcrypt');

// Registrar usuario
const hashedPassword = await bcrypt.hash(password, 10);

// Verificar login
const isValid = await bcrypt.compare(password, hashedPassword);
```

---

## 🎯 Recomendaciones por Tipo de Proyecto

| Tipo de Proyecto | Solución Recomendada |
|------------------|---------------------|
| **Demo/Prototipo** | Usuarios hardcodeados (actual) ✅ |
| **App Personal** | SQLite local + hashing |
| **App Pequeña** | Firebase Authentication 🔥 |
| **App Empresarial** | Backend propio con JWT |
| **App Grande** | OAuth2 + API REST + Microservicios |

---

## 📝 Pasos Rápidos para Agregar un Usuario AHORA

1. Abre `lib/src/features/auth/application/login_cubit.dart`
2. Busca la línea ~10 con `_validUsers`
3. Agrega una nueva línea:
   ```dart
   'tuemail@ejemplo.com': 'tupassword',
   ```
4. Guarda (Ctrl+S)
5. Hot Reload (r)
6. ¡Prueba tu nuevo usuario!

---

## 🐛 Solución de Problemas

### "No puedo iniciar sesión con mi nuevo usuario"
- Verifica que agregaste la coma al final
- Asegúrate de que el email y password estén entre comillas
- Haz Hot Restart (R) en lugar de Hot Reload

### "Quiero eliminar un usuario"
- Simplemente borra la línea completa del usuario
- Guarda y haz Hot Reload

### "¿Puedo tener el mismo email dos veces?"
- No, el Map no permite keys duplicadas
- Si lo intentas, solo quedará la última definición

---

## 💡 Ejemplos de Usuarios Personalizados

```dart
static final Map<String, String> _validUsers = {
  // Usuarios por departamento
  'ceo@empresa.com': 'Ceo2024!',
  'rrhh@empresa.com': 'Rrhh123',
  'ventas@empresa.com': 'Ventas$99',
  
  // Usuarios de prueba
  'qa@test.com': 'testing123',
  'dev@test.com': 'dev2024',
  
  // Usuarios familiares
  'papa@familia.com': 'papa123',
  'mama@familia.com': 'mama123',
  'hijo@familia.com': 'hijo123',
  
  // Tu usuario
  'tunombre@email.com': 'tupassword',
};
```

---

¡Ahora puedes gestionar tus propios usuarios! 🎉

**Recuerda:** Esta es una implementación para desarrollo/demostración. Para producción, siempre usa un backend seguro con autenticación profesional.
