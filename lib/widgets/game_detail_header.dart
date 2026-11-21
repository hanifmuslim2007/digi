import 'package:flutter/material.dart';

class GameDetailHeader extends StatelessWidget {
  const GameDetailHeader({
    super.key,
    required this.imageUrl,
    required this.genre,
    required this.batasPromo,
    required this.onShare,
  });

  final String imageUrl;
  final String genre;
  final String batasPromo;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 292,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
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
                IconButton(
                  onPressed: onShare,
                  tooltip: 'Bagikan promo',
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0x990C1017),
                    foregroundColor: Colors.white,
                    fixedSize: const Size(38, 38),
                  ),
                  icon: const Icon(Icons.share_outlined, size: 18),
                ),
              ],
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 4,
            child: Wrap(
              spacing: 7,
              runSpacing: 4,
              children: [
                if (genre.isNotEmpty)
                  Text(
                    genre.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF97A3B5),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                Text(
                  'Berakhir $batasPromo',
                  style: const TextStyle(
                    color: Color(0xFF97A3B5),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
