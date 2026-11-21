import 'package:flutter/material.dart';

class PlatformFilterRow extends StatelessWidget {
  const PlatformFilterRow({super.key});

  static const _platforms = ['All', 'PC', 'PS5', 'Xbox'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < _platforms.length; index++) ...[
          if (index > 0) const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: index == 0
                    ? const Color(0xFFBBF76A)
                    : const Color(0xFF161D28),
                borderRadius: BorderRadius.circular(100),
              ),
              alignment: Alignment.center,
              child: Text(
                _platforms[index],
                style: TextStyle(
                  color: index == 0
                      ? const Color(0xFF13200D)
                      : const Color(0xFF97A3B5),
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
