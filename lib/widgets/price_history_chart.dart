import 'package:flutter/material.dart';

import '../models/promo_game.dart';

class PriceHistoryChart extends StatelessWidget {
  const PriceHistoryChart({
    super.key,
    required this.hargaAwal,
    required this.hargaDiskon,
  });

  final double hargaAwal;
  final double hargaDiskon;

  static const _months = ['JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV'];

  @override
  Widget build(BuildContext context) {
    final tengah = (hargaAwal + hargaDiskon) / 2;
    final labels = [
      PromoGame.formatRupiah(hargaAwal),
      PromoGame.formatRupiah(tengah),
      PromoGame.formatRupiah(hargaDiskon),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Price history',
              style: TextStyle(
                color: Color(0xFFF6F7FB),
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF161D28),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Last 6 months',
                style: TextStyle(color: Color(0xFF97A3B5), fontSize: 10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 146,
          child: Stack(
            children: [
              for (var index = 0; index < labels.length; index++)
                Positioned(
                  top: 8 + (index * 43),
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 72,
                        child: Text(
                          labels[index],
                          style: const TextStyle(
                            color: Color(0xFF68768A),
                            fontSize: 9,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Divider(height: 1, color: Color(0xFF29323F)),
                      ),
                    ],
                  ),
                ),
              Positioned(
                top: 94,
                right: 2,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFBBF76A),
                    shape: OvalBorder(
                      side: const BorderSide(width: 2, color: Color(0xFF0C1017)),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 107,
                right: 0,
                child: Text(
                  'Harga terendah · ${PromoGame.formatRupiah(hargaDiskon)}',
                  style: const TextStyle(color: Color(0xFFBBF76A), fontSize: 10),
                ),
              ),
              Positioned(
                left: 82,
                right: 0,
                bottom: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (final month in _months)
                      Text(
                        month,
                        style: const TextStyle(
                          color: Color(0xFF68768A),
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
