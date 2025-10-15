# 📦 Guía de Git para Interactive Login

## 🎯 Archivos Actualizados

### ✅ `.gitignore` - Completamente Actualizado
El archivo `.gitignore` ahora incluye:

#### 📱 Flutter/Dart
- Build artifacts
- Generated files
- Packages y pub cache
- Flutter plugins

#### 🤖 Android
- Gradle files
- Local properties
- Keystores (archivos .jks, .keystore)
- Debug/Release builds
- GeneratedPluginRegistrant

#### 🍎 iOS/macOS
- Pods
- DerivedData
- Xcode user data
- Framework files
- Generated files

#### 💻 Windows/Linux
- Generated plugin files
- Build artifacts

#### 🔥 Firebase (preparado)
- google-services.json
- GoogleService-Info.plist
- firebase_options.dart

#### 🔐 Seguridad
- Archivos .env
- Credenciales
- API keys
- Secrets

#### 🛠️ Herramientas
- FVM (Flutter Version Management)
- Mason
- Logs y crashes
- Testing coverage

### ✅ `.gitattributes` - Nuevo Archivo
Configura el manejo correcto de:
- Line endings (LF/CRLF)
- Archivos binarios
- Archivos de texto
- Scripts multiplataforma

---

## 🚀 Comandos Git Básicos

### Primera vez (Inicializar repositorio)

```bash
# Inicializar Git
git init

# Agregar todos los archivos
git add .

# Primer commit
git commit -m "🎉 Initial commit - Interactive Login App"

# Conectar con GitHub (reemplaza con tu URL)
git remote add origin https://github.com/tu-usuario/interactive-login.git

# Subir al repositorio
git push -u origin main
```

### Workflow Diario

```bash
# Ver estado de archivos
git status

# Agregar archivos modificados
git add .

# Commit con mensaje descriptivo
git commit -m "✨ Descripción de tus cambios"

# Subir cambios
git push

# Descargar cambios
git pull
```

---

## 📋 Mensajes de Commit Recomendados

Usa emojis y prefijos descriptivos:

```bash
# Nuevas características
git commit -m "✨ feat: Agregar validación de email mejorada"

# Correcciones de bugs
git commit -m "🐛 fix: Corregir error en login button"

# Documentación
git commit -m "📝 docs: Actualizar README con credenciales"

# Refactorización
git commit -m "♻️ refactor: Componentizar email field"

# Estilos/UI
git commit -m "💄 style: Mejorar diseño del formulario"

# Testing
git commit -m "✅ test: Agregar tests para login cubit"

# Configuración
git commit -m "🔧 config: Actualizar .gitignore"

# Dependencias
git commit -m "📦 deps: Actualizar flutter_bloc a v9.1.1"

# Seguridad
git commit -m "🔒 security: Ocultar API keys del repositorio"
```

---

## 🔐 Seguridad: ¿Qué NO Subir?

### ⚠️ NUNCA subas estos archivos:

1. **Credenciales y API Keys**
   - ❌ google-services.json
   - ❌ GoogleService-Info.plist
   - ❌ .env files
   - ❌ Archivos con passwords
   - ❌ API keys hardcodeadas

2. **Keystores y Certificados**
   - ❌ *.jks
   - ❌ *.keystore
   - ❌ key.properties
   - ❌ Certificados privados

3. **Archivos de Configuración Local**
   - ❌ local.properties
   - ❌ Configuraciones personales del IDE

---

## 📁 Estructura Recomendada para Subir

### ✅ SI incluir en Git:

```
interactive_login/
├── lib/                    ✅ Todo el código fuente
│   ├── main.dart
│   └── src/
├── assets/                 ✅ Recursos públicos
│   └── images/
│       └── logo_app.png   ✅ Imágenes de la app
├── test/                  ✅ Tests
├── android/               ⚠️ Solo archivos base (no builds)
├── ios/                   ⚠️ Solo archivos base (no builds)
├── pubspec.yaml           ✅ Dependencias
├── analysis_options.yaml  ✅ Configuración de linter
├── README.md              ✅ Documentación
├── .gitignore             ✅ Configuración Git
└── .gitattributes         ✅ Configuración Git
```

### ❌ NO incluir:

```
interactive_login/
├── .dart_tool/            ❌ Cache de Dart
├── .idea/                 ❌ Configuración de IDE
├── build/                 ❌ Archivos compilados
├── .flutter-plugins       ❌ Generados automáticamente
└── android/
    ├── .gradle/          ❌ Cache de Gradle
    └── app/
        └── release/      ❌ Builds de release
```

---

## 🔄 Casos Especiales

### Si ya subiste archivos sensibles por error

```bash
# Remover archivo del historial
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch ruta/del/archivo" \
  --prune-empty --tag-name-filter cat -- --all

# Forzar push
git push origin --force --all
```

⚠️ **Importante:** Después de esto, CAMBIA las credenciales expuestas.

### Agregar archivo grande (assets, etc.)

Si tienes archivos muy grandes, considera usar Git LFS:

```bash
# Instalar Git LFS
git lfs install

# Rastrear archivos grandes
git lfs track "*.png"
git lfs track "*.jpg"

# Commit del archivo .gitattributes
git add .gitattributes
git commit -m "📦 Configure Git LFS"
```

---

## 🌿 Branching Strategy

### Para desarrollo solo

```bash
# Trabajar en la rama main
git checkout main
git pull
# hacer cambios
git add .
git commit -m "mensaje"
git push
```

### Para equipos

```bash
# Crear rama de feature
git checkout -b feature/nueva-funcionalidad

# Hacer cambios y commits
git add .
git commit -m "✨ feat: Nueva funcionalidad"

# Subir rama
git push -u origin feature/nueva-funcionalidad

# Merge a main (después de review)
git checkout main
git merge feature/nueva-funcionalidad
git push
```

---

## 📊 Verificar lo que se va a subir

```bash
# Ver qué archivos están siendo trackeados
git ls-files

# Ver qué archivos están siendo ignorados
git status --ignored

# Ver diferencias antes de commit
git diff

# Ver qué se agregó al staging area
git diff --staged
```

---

## 🛠️ Comandos Útiles

```bash
# Deshacer último commit (mantener cambios)
git reset --soft HEAD~1

# Deshacer cambios en un archivo
git checkout -- archivo.dart

# Ver historial de commits
git log --oneline --graph

# Ver quién modificó cada línea
git blame archivo.dart

# Crear tag para release
git tag -a v1.0.0 -m "Release version 1.0.0"
git push --tags
```

---

## 📝 Archivo README.md Sugerido

Crea un archivo `README.md` profesional:

```markdown
# 🔐 Interactive Login

Flutter app con autenticación interactiva y gestión de estado con Cubit.

## 🚀 Features

- ✅ Autenticación con validación avanzada
- ✅ Gestión de estado con flutter_bloc
- ✅ UI moderna con Material Design 3
- ✅ Componentes reutilizables
- ✅ Tema centralizado

## 📱 Screenshots

[Agrega capturas de pantalla aquí]

## 🛠️ Instalación

\`\`\`bash
flutter pub get
flutter run
\`\`\`

## 🔑 Credenciales de Prueba

Ver `CREDENCIALES.md`

## 📚 Documentación

- [Guía de Uso](GUIA_USO.md)
- [Gestión de Usuarios](GESTION_USUARIOS.md)
- [Desafíos Completados](DESAFIOS_COMPLETADOS.md)

## 🤝 Contribuir

Pull requests son bienvenidos!

## 📄 Licencia

MIT
```

---

## ✅ Checklist antes de Push

Antes de hacer `git push`, verifica:

- [ ] ¿Removí todos los `print()` de debug?
- [ ] ¿No hay archivos sensibles (.env, keys)?
- [ ] ¿El código compila sin errores?
- [ ] ¿Actualicé la documentación si es necesario?
- [ ] ¿El mensaje de commit es descriptivo?
- [ ] ¿Corrí `flutter analyze`?
- [ ] ¿Las credenciales son de prueba/demo?

---

## 🎓 Mejores Prácticas

1. **Commits pequeños y frecuentes** mejor que grandes y esporádicos
2. **Mensajes descriptivos** que expliquen QUÉ y POR QUÉ
3. **No subir builds** ni archivos generados
4. **Proteger credenciales** siempre
5. **Revisar antes de push** con `git status` y `git diff`
6. **Pull antes de push** para evitar conflictos
7. **Usar branches** para features grandes
8. **Taggear releases** para versiones estables

---

## 🔗 Recursos

- [Git Documentation](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitMoji](https://gitmoji.dev/) - Emojis para commits

---

¡Tu repositorio está listo para ser usado profesionalmente! 🎉
