import 'package:flutter/material.dart';

class DiscoverHeader extends StatelessWidget {
  const DiscoverHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'PEMANTAU DISKON GAME',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFFF6F7FB),
                    fontSize: compact ? 24 : 29,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.5,
                  ),
                ),
              ),
              if (!compact) ...[
                const SizedBox(width: 8),
                const Text(
                  'PLAY MORE. PAY LESS.',
                  style: TextStyle(
                    color: Color(0xFF97A3B5),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
