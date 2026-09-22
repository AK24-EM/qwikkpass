import 'package:flutter/material.dart';
import 'package:qwikpass/core/theme/app_theme.dart';

class PerforatedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final bool showPerforations;
  final PerforationPosition perforationPosition;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  const PerforatedCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.showPerforations = true,
    this.perforationPosition = PerforationPosition.bottom,
    this.width,
    this.height,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: width,
      height: height,
      margin: margin,
      child: Stack(
        children: [
          // Main card
          Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? AppTheme.cardDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.borderGray,
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (perforationPosition == PerforationPosition.top && showPerforations)
                    _buildPerforationLine(),
                  Flexible(
                    child: Padding(
                      padding: padding ?? const EdgeInsets.all(16),
                      child: child,
                    ),
                  ),
                  if (perforationPosition == PerforationPosition.bottom && showPerforations)
                    _buildPerforationLine(),
                ],
              ),
            ),
          ),
          
          // Perforation notches
          if (showPerforations) ..._buildNotches(context),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: content,
      );
    }

    return content;
  }

  Widget _buildPerforationLine() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.borderGray.withOpacity(0),
            AppTheme.borderGray,
            AppTheme.borderGray.withOpacity(0),
          ],
        ),
      ),
      child: CustomPaint(
        painter: _DashedLinePainter(),
        size: const Size(double.infinity, 1),
      ),
    );
  }

  List<Widget> _buildNotches(BuildContext context) {
    final bool isTop = perforationPosition == PerforationPosition.top;
    final double notchSize = 14;
    
    return [
      // Left notch
      Positioned(
        left: -notchSize / 2,
        top: isTop ? -notchSize / 2 : null,
        bottom: isTop ? null : -notchSize / 2,
        child: _buildCircularNotch(notchSize),
      ),
      // Right notch
      Positioned(
        right: -notchSize / 2,
        top: isTop ? -notchSize / 2 : null,
        bottom: isTop ? null : -notchSize / 2,
        child: _buildCircularNotch(notchSize),
      ),
    ];
  }

  Widget _buildCircularNotch(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppTheme.backgroundDark,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppTheme.borderGray,
          width: 1,
        ),
      ),
    );
  }
}

enum PerforationPosition {
  top,
  bottom,
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.borderGray
      ..strokeWidth = 1;

    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
