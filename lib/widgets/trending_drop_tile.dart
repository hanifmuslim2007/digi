import 'package:flutter/material.dart';
import '../config/app_theme.dart';

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
              errorBuilder: (context, error, stackTrace) => SizedBox(
                width: 58,
                height: 58,
                child: ColoredBox(
                  color: context.palette.surfaceAlt,
                  child: Icon(
                    Icons.videogame_asset_outlined,
                    color: context.palette.textSubtle,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: context.palette.text,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  platform,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: context.palette.textMuted,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currentPrice,
                style: TextStyle(color: context.palette.text, fontSize: 17),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    originalPrice,
                    style: TextStyle(
                      color: context.palette.textSubtle,
                      fontSize: 10,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    discount,
                    style: TextStyle(
                      color: context.palette.accent,
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
