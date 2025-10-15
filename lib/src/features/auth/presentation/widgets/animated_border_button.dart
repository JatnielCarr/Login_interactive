import 'package:flutter/material.dart';

/// Widget personalizado que muestra una animación de borde deslizante
/// para indicar estado de carga
class AnimatedBorderButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final double height;

  const AnimatedBorderButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.height = 56,
  });

  @override
  State<AnimatedBorderButton> createState() => _AnimatedBorderButtonState();
}

class _AnimatedBorderButtonState extends State<AnimatedBorderButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    if (widget.isLoading) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(AnimatedBorderButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !oldWidget.isLoading) {
      _animationController.repeat();
    } else if (!widget.isLoading && oldWidget.isLoading) {
      _animationController.stop();
      _animationController.reset();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SizedBox(
      width: double.infinity,
      height: widget.height,
      child: Stack(
        children: [
          // Botón base
          SizedBox(
            width: double.infinity,
            height: widget.height,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: widget.isLoading
                    ? colorScheme.primary.withOpacity(0.7)
                    : colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                elevation: widget.isLoading ? 0 : 2,
                disabledBackgroundColor:
                    colorScheme.primary.withOpacity(0.6),
                disabledForegroundColor:
                    colorScheme.onPrimary.withOpacity(0.6),
              ),
              onPressed: widget.isLoading ? null : widget.onPressed,
              child: widget.isLoading
                  ? const SizedBox.shrink() // Espacio vacío durante carga
                  : Text(
                      widget.text,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: colorScheme.onPrimary,
                      ),
                    ),
            ),
          ),
          // Animación de borde cuando está en loading
          if (widget.isLoading)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _BorderAnimationPainter(
                      progress: _animation.value,
                      color: colorScheme.onPrimary,
                      borderRadius: 12,
                    ),
                  );
                },
              ),
            ),
          // Texto "Loading..." centrado
          if (widget.isLoading)
            Center(
              child: Text(
                'Loading...',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// CustomPainter que dibuja una línea animada alrededor del borde del botón
class _BorderAnimationPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double borderRadius;

  _BorderAnimationPainter({
    required this.progress,
    required this.color,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Crear path del borde redondeado
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    final path = Path()..addRRect(rrect);

    // Calcular la longitud total del path
    final pathMetrics = path.computeMetrics().first;
    final totalLength = pathMetrics.length;

    // Longitud de la línea visible (20% del total)
    final visibleLength = totalLength * 0.2;

    // Posición actual basada en el progreso
    final currentPosition = totalLength * progress;

    // Extraer el segmento visible
    final extractPath = pathMetrics.extractPath(
      currentPosition,
      currentPosition + visibleLength,
    );

    // Dibujar el segmento
    canvas.drawPath(extractPath, paint);
  }

  @override
  bool shouldRepaint(_BorderAnimationPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.borderRadius != borderRadius;
  }
}

