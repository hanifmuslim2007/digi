import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_theme.dart';
import '../providers/theme_mode_provider.dart';

class DiscoverHeader extends StatelessWidget {
  const DiscoverHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = context.watch<ThemeModeProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 360;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'DIGI: DISKON GAME',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: context.palette.text,
                    fontSize: compact ? 24 : 29,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.5,
                  ),
                ),
              ),
              if (!compact) ...[
                const SizedBox(width: 8),
                Text(
                  'PLAY MORE. PAY LESS.',
                  style: TextStyle(
                    color: context.palette.textMuted,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
              IconButton(
                onPressed: tema.toggle,
                tooltip: tema.isDark ? 'Aktifkan tema putih' : 'Aktifkan tema gelap',
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  tema.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  color: context.palette.accent,
                  size: 22,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
