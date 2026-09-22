import 'package:flutter/material.dart';
import 'package:qwikpass/core/theme/app_theme.dart';

/// A card widget styled to look like a physical ticket stub
class StubCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? price;
  final String? tag;
  final Color? tagColor;
  final Widget? image;
  final String? imageUrl;
  final VoidCallback? onTap;
  final List<Widget>? additionalInfo;
  final bool showTearEdge;
  final EdgeInsetsGeometry? margin;

  const StubCard({
    Key? key,
    this.title,
    this.subtitle,
    this.price,
    this.tag,
    this.tagColor,
    this.image,
    this.imageUrl,
    this.onTap,
    this.additionalInfo,
    this.showTearEdge = true,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.cardDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.borderGray,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image section
                if (image != null || imageUrl != null)
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(11),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: image ??
                          (imageUrl != null
                              ? Image.network(
                                  imageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      _buildPlaceholder(),
                                )
                              : _buildPlaceholder()),
                    ),
                  ),

                // Content section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tag
                      if (tag != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: (tagColor ?? AppTheme.primaryYellow)
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            tag!.toUpperCase(),
                            style: AppTheme.monospaceSmall(context).copyWith(
                              color: tagColor ?? AppTheme.primaryYellow,
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                          ),
                        ),

                      if (tag != null) const SizedBox(height: 12),

                      // Title
                      if (title != null)
                        Text(
                          title!,
                          style: Theme.of(context).textTheme.headlineSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                      if (title != null && subtitle != null)
                        const SizedBox(height: 6),

                      // Subtitle
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: AppTheme.monospaceSmall(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                      // Additional info
                      if (additionalInfo != null && additionalInfo!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: additionalInfo!,
                          ),
                        ),

                      // Price
                      if (price != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'FROM',
                                style: AppTheme.monospaceXSmall(context),
                              ),
                              Text(
                                price!,
                                style: AppTheme.monospaceMedium(context)
                                    .copyWith(
                                  color: AppTheme.primaryYellow,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                // Tear edge at bottom
                if (showTearEdge) _buildTearEdge(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppTheme.surfaceDark,
      child: const Center(
        child: Icon(
          Icons.image_outlined,
          size: 48,
          color: AppTheme.textTertiary,
        ),
      ),
    );
  }

  Widget _buildTearEdge() {
    return CustomPaint(
      painter: _TearEdgePainter(),
      size: const Size(double.infinity, 8),
    );
  }
}

class _TearEdgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.borderGray
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);

    const triangleWidth = 12.0;
    const triangleHeight = 6.0;
    double x = 0;

    while (x < size.width) {
      path.lineTo(x + triangleWidth / 2, triangleHeight);
      path.lineTo(x + triangleWidth, 0);
      x += triangleWidth;
    }

    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Info row widget for event details
class StubInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;
  final Color? textColor;

  const StubInfoRow({
    Key? key,
    required this.icon,
    required this.text,
    this.iconColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: iconColor ?? AppTheme.textSecondary,
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: AppTheme.monospaceXSmall(context).copyWith(
              color: textColor ?? AppTheme.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
