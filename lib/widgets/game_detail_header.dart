import 'package:flutter/material.dart';

class GameDetailHeader extends StatelessWidget {
  const GameDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 292,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://cdn.akamai.steamstatic.com/steam/apps/990080/header.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const ColoredBox(
              color: Color(0xFF202936),
              child: Icon(
                Icons.auto_awesome,
                color: Color(0xFF68768A),
                size: 48,
              ),
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x590C1017),
                  Color(0x000C1017),
                  Color(0xFF0C1017),
                ],
              ),
            ),
          ),
          Positioned(
            top: 14,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  tooltip: 'Back',
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0x990C1017),
                    foregroundColor: Colors.white,
                    fixedSize: const Size(38, 38),
                  ),
                  icon: const Icon(Icons.arrow_back, size: 18),
                ),
                const Text(
                  'GAME DETAILS',
                  style: TextStyle(
                    color: Color(0xFFF6F7FB),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
                Container(
                  width: 38,
                  height: 38,
                  decoration: const ShapeDecoration(
                    color: Color(0x990C1017),
                    shape: OvalBorder(),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            left: 24,
            right: 24,
            bottom: 4,
            child: Wrap(
              spacing: 7,
              runSpacing: 4,
              children: [
                Text(
                  'OPEN-WORLD RPG',
                  style: TextStyle(
                    color: Color(0xFF97A3B5),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  'Standard edition',
                  style: TextStyle(color: Color(0xFF97A3B5), fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
