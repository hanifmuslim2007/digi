import 'package:flutter/material.dart';

import '../widgets/custom_search_bar.dart';
import '../widgets/discover_bottom_nav.dart';
import '../widgets/discover_header.dart';
import '../widgets/platform_filter_row.dart';
import '../widgets/top_deal_card.dart';
import '../widgets/trending_drop_tile.dart';
import 'game_detail_page.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    const games = [
      (
        title: 'Cyberpunk 2077',
        platform: 'Steam · PC',
        originalPrice: '\$59.99',
        currentPrice: '\$29.99',
        discount: '−50%',
        imageUrl:
            'https://cdn.akamai.steamstatic.com/steam/apps/1091500/header.jpg',
      ),
      (
        title: 'God of War Ragnarök',
        platform: 'PlayStation · PS5',
        originalPrice: '\$69.99',
        currentPrice: '\$39.99',
        discount: '−43%',
        imageUrl:
            'https://cdn.akamai.steamstatic.com/steam/apps/2322010/header.jpg',
      ),
      (
        title: 'Forza Horizon 5',
        platform: 'Xbox · Series X|S',
        originalPrice: '\$59.99',
        currentPrice: '\$29.99',
        discount: '−50%',
        imageUrl:
            'https://cdn.akamai.steamstatic.com/steam/apps/1551360/header.jpg',
      ),
    ];
    final normalizedQuery = _searchQuery.trim().toLowerCase();
    final filteredGames = games
        .where(
          (game) =>
              game.title.toLowerCase().contains(normalizedQuery) ||
              game.platform.toLowerCase().contains(normalizedQuery),
        )
        .toList();
    final showTopDeal =
        normalizedQuery.isEmpty || 'hogwarts legacy'.contains(normalizedQuery);

    return Scaffold(
      backgroundColor: const Color(0xFF0C1017),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DiscoverHeader(),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomSearchBar(
                      onChanged: (value) {
                        setState(() => _searchQuery = value);
                      },
                    ),
                    const SizedBox(height: 20),
                    const PlatformFilterRow(),
                    const SizedBox(height: 20),
                    if (showTopDeal) ...[
                      const _SectionHeading(
                        title: 'Top Deals',
                        action: 'Explore all',
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        key: const Key('top-deal-card'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => const GameDetailPage(),
                            ),
                          );
                        },
                        child: const TopDealCard(),
                      ),
                    ],
                    const SizedBox(height: 20),
                    _SectionHeading(
                      title: 'Trending Drops',
                      action: 'View all',
                    ),
                    const SizedBox(height: 8),
                    if (filteredGames.isEmpty && !showTopDeal)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text(
                            'No games found',
                            style: TextStyle(color: Color(0xFF97A3B5)),
                          ),
                        ),
                      )
                    else
                      Column(
                        children: [
                          for (final game in filteredGames)
                            TrendingDropTile(
                              title: game.title,
                              platform: game.platform,
                              originalPrice: game.originalPrice,
                              currentPrice: game.currentPrice,
                              discount: game.discount,
                              imageUrl: game.imageUrl,
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const DiscoverBottomNav(),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.action});

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFF6F7FB),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          action,
          style: const TextStyle(color: Color(0xFF97A3B5), fontSize: 12),
        ),
      ],
    );
  }
}
