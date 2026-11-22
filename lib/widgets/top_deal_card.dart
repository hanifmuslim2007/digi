import 'package:flutter/material.dart';

import '../models/promo_game.dart';
import '../config/app_theme.dart';

class TopDealCard extends StatelessWidget {
  const TopDealCard({super.key, required this.promo});

  final PromoGame promo;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: 248,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              promo.gambarGame,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => ColoredBox(
                color: context.palette.surfaceAlt,
                child: Icon(
                  Icons.videogame_asset_outlined,
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
                    Color(0x000C1017),
                    Color(0x800C1017),
                    Color(0xF50C1017),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xB80C1017),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'DEAL OF THE DAY',
                          style: TextStyle(
                            color: context.palette.text,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.3,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: context.palette.accent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          promo.labelDiskon,
                          style: TextStyle(
                            color: context.palette.onAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        promo.namaGame,
                        style: TextStyle(
                          color: context.palette.text,
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.9,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              promo.platform,
                              style: TextStyle(
                                color: context.palette.textMuted,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerRight,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    promo.formatHargaAwal,
                                    style: TextStyle(
                                      color: context.palette.textSubtle,
                                      fontSize: 15,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    promo.formatHargaDiskon,
                                    style: TextStyle(
                                      color: context.palette.accent,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
