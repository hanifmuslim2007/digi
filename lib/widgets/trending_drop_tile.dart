import 'package:flutter/material.dart';

class TrendingDropTile extends StatelessWidget {
  const TrendingDropTile({
    super.key,
    required this.title,
    required this.platform,
    required this.originalPrice,
    required this.currentPrice,
    required this.discount,
    required this.imageUrl,
  });

  final String title;
  final String platform;
  final String originalPrice;
  final String currentPrice;
  final String discount;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              width: 58,
              height: 58,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const SizedBox(
                width: 58,
                height: 58,
                child: ColoredBox(
                  color: Color(0xFF202936),
                  child: Icon(
                    Icons.videogame_asset_outlined,
                    color: Color(0xFF68768A),
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFF6F7FB),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  platform,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF97A3B5),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currentPrice,
                style: const TextStyle(color: Color(0xFFF6F7FB), fontSize: 17),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    originalPrice,
                    style: const TextStyle(
                      color: Color(0xFF68768A),
                      fontSize: 10,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    discount,
                    style: const TextStyle(
                      color: Color(0xFFBBF76A),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
