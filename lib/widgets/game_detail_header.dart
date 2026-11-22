import 'package:flutter/material.dart';
import '../config/app_theme.dart';

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
            errorBuilder: (context, error, stackTrace) => ColoredBox(
              color: context.palette.surfaceAlt,
              child: Icon(
                Icons.auto_awesome,
                color: context.palette.textSubtle,
                size: 48,
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x590C1017),
                  Color(0x000C1017),
                  context.palette.background,
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
                  icon: Icon(Icons.arrow_back, size: 18),
                ),
                Text(
                  'GAME DETAILS',
                  style: TextStyle(
                    color: context.palette.text,
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
                  icon: Icon(Icons.share_outlined, size: 18),
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
                    style: TextStyle(
                      color: context.palette.textMuted,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                Text(
                  'Berakhir $batasPromo',
                  style: TextStyle(
                    color: context.palette.textMuted,
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
