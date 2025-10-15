# 🔑 CREDENCIALES DISPONIBLES - RESUMEN RÁPIDO

## ✅ Usuarios Activos

```
┌─────────────────────────────────────────────────────┐
│                  USUARIO 1 - TEST                   │
├─────────────────────────────────────────────────────┤
│ Email:    test@test.com                             │
│ Password: 123456                                    │
│ Uso:      Usuario de prueba básico                 │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│                 USUARIO 2 - ADMIN                   │
├─────────────────────────────────────────────────────┤
│ Email:    admin@admin.com                           │
│ Password: admin123                                  │
│ Uso:      Usuario administrador                     │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│                USUARIO 3 - EXAMPLE                  │
├─────────────────────────────────────────────────────┤
│ Email:    user@example.com                          │
│ Password: pass123                                   │
│ Uso:      Usuario ejemplo estándar                 │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│                 USUARIO 4 - DEMO                    │
├─────────────────────────────────────────────────────┤
│ Email:    demo@demo.com                             │
│ Password: demo123                                   │
│ Uso:      Usuario para demostraciones              │
└─────────────────────────────────────────────────────┘
```

---

## 🚀 Inicio Rápido

### Probar Login Exitoso
```
1. Abre la app
2. Email: test@test.com
3. Password: 123456
4. Clic en Login
5. ✅ Verás mensaje de éxito verde
```

### Probar Password Incorrecta
```
1. Email: test@test.com
2. Password: wrongpass
3. Clic en Login
4. ❌ Verás: "Contraseña incorrecta"
```

### Probar Usuario No Existe
```
1. Email: noexiste@test.com
2. Password: cualquiera
3. Clic en Login
4. ❌ Verás: "Usuario no encontrado"
```

---

## ➕ Agregar Tu Propio Usuario

**Archivo:** `lib/src/features/auth/application/login_cubit.dart`

**Busca esto (línea ~10):**
```dart
static final Map<String, String> _validUsers = {
  'test@test.com': '123456',
  'admin@admin.com': 'admin123',
  'user@example.com': 'pass123',
  'demo@demo.com': 'demo123',
};
```

**Agrega tu usuario:**
```dart
static final Map<String, String> _validUsers = {
  'test@test.com': '123456',
  'admin@admin.com': 'admin123',
  'user@example.com': 'pass123',
  'demo@demo.com': 'demo123',
  'tuemail@ejemplo.com': 'tupassword',  // ⬅️ Agrega aquí
};
```

**Guarda y recarga (Hot Reload: r)**

---

## 📊 Tabla Comparativa

| Email | Password | Largo Pass | Tiene Números | Tiene Letras |
|-------|----------|------------|---------------|--------------|
| test@test.com | 123456 | 6 | ✅ | ❌ |
| admin@admin.com | admin123 | 8 | ✅ | ✅ |
| user@example.com | pass123 | 7 | ✅ | ✅ |
| demo@demo.com | demo123 | 7 | ✅ | ✅ |

---

## 💡 Tips

✅ **Todos los usuarios funcionan** para probar la app  
✅ **Mensajes diferentes** para password incorrecta vs usuario no existe  
✅ **Validación completa** de formato de email  
✅ **Passwords deben tener** mínimo 6 caracteres, letras Y números  

---

## 📖 Más Información

- **Gestión completa:** Ver `GESTION_USUARIOS.md`
- **Guía de uso:** Ver `GUIA_USO.md`
- **Desafíos completados:** Ver `DESAFIOS_COMPLETADOS.md`

---

**Nota:** Estas son credenciales de DEMOSTRACIÓN únicamente.  
Para producción, conecta con una API real y usa autenticación segura.

---

🎯 **¡Listo para empezar!** Ejecuta `flutter run` y prueba cualquier usuario.
