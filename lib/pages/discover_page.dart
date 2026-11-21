import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/promo_game_provider.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/discover_bottom_nav.dart';
import '../widgets/discover_header.dart';
import '../widgets/platform_filter_row.dart';
import '../widgets/top_deals_carousel.dart';
import '../widgets/trending_drop_tile.dart';
import 'game_detail_page.dart';
import 'promo_form_page.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  void _bukaDetail(BuildContext context, int idPromo) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => GameDetailPage(idPromo: idPromo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PromoGameProvider>();
    final promos = provider.filteredPromos;
    final topDeals = provider.topDeals;
    final trending = promos
        .where((promo) => !topDeals.any((item) => item.idPromo == promo.idPromo))
        .toList();
    final adaFilter =
        provider.query.trim().isNotEmpty || provider.platform != 'All';

    return Scaffold(
      backgroundColor: const Color(0xFF0C1017),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFBBF76A),
        foregroundColor: const Color(0xFF13200D),
        tooltip: 'Tambah promo',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => const PromoFormPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DiscoverHeader(),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 96),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomSearchBar(
                      onChanged: provider.setQuery,
                    ),
                    const SizedBox(height: 20),
                    PlatformFilterRow(
                      selected: provider.platform,
                      onChanged: provider.setPlatform,
                    ),
                    const SizedBox(height: 20),
                    if (provider.loading && promos.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 64),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFBBF76A),
                          ),
                        ),
                      )
                    else if (provider.error != null && promos.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48),
                        child: Column(
                          children: [
                            Text(
                              provider.error!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF97A3B5),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 16),
                            OutlinedButton.icon(
                              onPressed: provider.loadPromos,
                              icon: const Icon(Icons.refresh, size: 16),
                              label: const Text('Coba lagi'),
                            ),
                          ],
                        ),
                      )
                    else ...[
                      if (topDeals.isNotEmpty) ...[
                        const _SectionHeading(
                          title: 'Top Deals',
                          action: '4 terpopuler',
                        ),
                        const SizedBox(height: 12),
                        TopDealsCarousel(
                          promos: topDeals,
                          onTap: (promo) => _bukaDetail(context, promo.idPromo),
                        ),
                        const SizedBox(height: 20),
                      ],
                      _SectionHeading(
                        title: 'Trending Drops',
                        action: 'View all',
                      ),
                      const SizedBox(height: 8),
                      if (trending.isEmpty && adaFilter)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Text(
                              'No games found',
                              style: TextStyle(color: Color(0xFF97A3B5)),
                            ),
                          ),
                        )
                      else if (trending.isNotEmpty)
                        Column(
                          children: [
                            for (final promo in trending)
                              GestureDetector(
                                onTap: () => _bukaDetail(context, promo.idPromo),
                                child: TrendingDropTile(
                                  title: promo.namaGame,
                                  platform: promo.platform,
                                  originalPrice: promo.formatHargaAwal,
                                  currentPrice: promo.formatHargaDiskon,
                                  discount: promo.labelDiskon,
                                  imageUrl: promo.gambarGame,
                                ),
                              ),
                          ],
                        ),
                    ],
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
