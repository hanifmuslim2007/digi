import 'package:flutter/material.dart';

import '../widgets/bottom_action_bar.dart';
import '../widgets/game_detail_header.dart';
import '../widgets/price_history_chart.dart';
import '../widgets/store_comparison_card.dart';

class GameDetailPage extends StatelessWidget {
  const GameDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1017),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const GameDetailHeader(),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hogwarts Legacy',
                      style: TextStyle(
                        color: Color(0xFFF6F7FB),
                        fontSize: 31,
                        fontWeight: FontWeight.w400,
                        height: 1.1,
                        letterSpacing: -1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'PC / Warner Bros. Games',
                      style: TextStyle(color: Color(0xFF97A3B5), fontSize: 11),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        const Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '\$29.99',
                                  style: TextStyle(
                                    color: Color(0xFFF6F7FB),
                                    fontSize: 46,
                                    fontWeight: FontWeight.w800,
                                    height: 1.1,
                                    letterSpacing: -2,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  '\$59.99',
                                  style: TextStyle(
                                    color: Color(0xFF68768A),
                                    fontSize: 15,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFBBF76A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            '−50%',
                            style: TextStyle(
                              color: Color(0xFF13200D),
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    const StoreComparisonCard(),
                    const SizedBox(height: 22),
                    const PriceHistoryChart(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomActionBar(),
    );
  }
}
