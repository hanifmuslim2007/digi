import 'package:flutter/material.dart';

import '../models/promo_game.dart';

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
              errorBuilder: (context, error, stackTrace) => const ColoredBox(
                color: Color(0xFF202936),
                child: Icon(
                  Icons.videogame_asset_outlined,
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
                    Color(0x000C1017),
                    Color(0x800C1017),
                    Color(0xF50C1017),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xB80C1017),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'DEAL OF THE DAY',
                          style: TextStyle(
                            color: Color(0xFFF6F7FB),
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.3,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFBBF76A),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          promo.labelDiskon,
                          style: const TextStyle(
                            color: Color(0xFF13200D),
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
                        style: const TextStyle(
                          color: Color(0xFFF6F7FB),
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.9,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              promo.platform,
                              style: const TextStyle(
                                color: Color(0xFF97A3B5),
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
                                    style: const TextStyle(
                                      color: Color(0xFF68768A),
                                      fontSize: 15,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    promo.formatHargaDiskon,
                                    style: const TextStyle(
                                      color: Color(0xFFBBF76A),
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
