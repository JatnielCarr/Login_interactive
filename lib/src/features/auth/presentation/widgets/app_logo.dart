import 'package:flutter/material.dart';

/// Logo de la aplicación con diseño responsive.
///
/// Calcula automáticamente su tamaño basado en el ancho disponible,
/// con límites máximos y mínimos para garantizar una buena visualización
/// en cualquier dispositivo.
///
/// Incluye:
/// - Hero animation para transiciones suaves
/// - Sombra con el color primario del tema
/// - Fallback con gradiente si falla la carga de la imagen
class AppLogo extends StatelessWidget {
  /// Tamaño opcional del logo. Si no se proporciona, se calcula
  /// automáticamente basado en el ancho de la pantalla.
  final double? size;

  const AppLogo({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calcula el tamaño responsive:
        // - 35% del ancho disponible
        // - Mínimo 120px (para pantallas muy pequeñas)
        // - Máximo 220px (para pantallas muy grandes)
        final calculatedSize = size ??
            (constraints.maxWidth * 0.35).clamp(120.0, 220.0);

        return Hero(
          tag: 'app_logo',
          child: Container(
            height: calculatedSize,
            width: calculatedSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/logo_app.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      size: calculatedSize * 0.5,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
