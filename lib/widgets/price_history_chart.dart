import 'package:flutter/material.dart';

import '../models/promo_game.dart';
import '../config/app_theme.dart';

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
            Text(
              'Price history',
              style: TextStyle(
                color: context.palette.text,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(
                color: context.palette.surface,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Last 6 months',
                style: TextStyle(color: context.palette.textMuted, fontSize: 10),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
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
                          style: TextStyle(
                            color: context.palette.textSubtle,
                            fontSize: 9,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Divider(height: 1, color: context.palette.border),
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
                    color: context.palette.accent,
                    shape: OvalBorder(
                      side: BorderSide(width: 2, color: context.palette.background),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 107,
                right: 0,
                child: Text(
                  'Harga terendah · ${PromoGame.formatRupiah(hargaDiskon)}',
                  style: TextStyle(color: context.palette.accent, fontSize: 10),
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
                        style: TextStyle(
                          color: context.palette.textSubtle,
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
