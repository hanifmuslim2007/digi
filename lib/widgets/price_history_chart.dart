import 'package:flutter/material.dart';

class PriceHistoryChart extends StatelessWidget {
  const PriceHistoryChart({super.key});

  static const _axisLabels = ['\$59.99', '\$44.99', '\$29.99'];
  static const _months = ['JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV'];

  @override
  Widget build(BuildContext context) {
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
              for (var index = 0; index < _axisLabels.length; index++)
                Positioned(
                  top: 8 + (index * 43),
                  left: 0,
                  right: 0,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 42,
                        child: Text(
                          _axisLabels[index],
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
                  decoration: const ShapeDecoration(
                    color: Color(0xFFBBF76A),
                    shape: OvalBorder(
                      side: BorderSide(width: 2, color: Color(0xFF0C1017)),
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: 107,
                right: 0,
                child: Text(
                  'Historical Low · \$29.99',
                  style: TextStyle(color: Color(0xFFBBF76A), fontSize: 10),
                ),
              ),
              Positioned(
                left: 52,
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
