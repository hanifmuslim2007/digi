import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class PlatformFilterRow extends StatelessWidget {
  const PlatformFilterRow({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const platforms = ['All', 'PC', 'PS5', 'Xbox'];

  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < platforms.length; index++) ...[
          if (index > 0) const SizedBox(width: 8),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onChanged(platforms[index]),
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: platforms[index] == selected
                        ? context.palette.accent
                        : context.palette.surface,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    platforms[index],
                    style: TextStyle(
                      color: platforms[index] == selected
                          ? context.palette.onAccent
                          : context.palette.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
