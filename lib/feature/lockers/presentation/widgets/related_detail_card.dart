import 'package:dnsc_locker/core/helper/text_size_responsive.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:flutter/material.dart';

class RelatedDetailCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String data;
  final Color backgroundColorPalette;
  final void Function()? onTapped;

  const RelatedDetailCard({
    super.key,
    required this.icon,
    required this.label,
    required this.data,
    required this.backgroundColorPalette,
    this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: backgroundColorPalette,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTapped,
        splashColor: Palette.secondaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🏷 Label
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 0.8,
                  color: Palette.lightShadeSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              // 🔢 Data Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon Box
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: backgroundColorPalette == Palette.secondaryColor
                          ? Palette.accentColor
                          : Palette.secondaryColor.withValues(alpha: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      size: 28,
                      color: backgroundColorPalette == Palette.secondaryColor
                          ? Palette.secondaryColor
                          : Palette.accentColor.withValues(alpha: 1),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Data (safe for long text)
                  Expanded(
                    child: Text(
                      data,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: TextSizeResponsive.fontSizeForData(data),
                        color: Palette.lightShadePrimary,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
