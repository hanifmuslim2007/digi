import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/promo_game.dart';
import '../providers/promo_game_provider.dart';
import '../widgets/cheapshark_sync_button.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/discover_bottom_nav.dart';
import '../widgets/discover_header.dart';
import '../widgets/platform_filter_row.dart';
import '../widgets/top_deals_carousel.dart';
import '../widgets/trending_drop_tile.dart';
import 'game_detail_page.dart';
import 'promo_form_page.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  static const _jumlahPerHalaman = 4;

  final ScrollController _scrollController = ScrollController();
  int _visibleCount = _jumlahPerHalaman;
  bool _loadingMore = false;
  DateTime? _terakhirRefresh;
  String? _signature;

  List<PromoGame> _trending(PromoGameProvider provider) {
    final topDeals = provider.topDeals;
    return provider.filteredPromos
        .where((promo) => !topDeals.any((item) => item.idPromo == promo.idPromo))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_saatGulir);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_saatGulir);
    _scrollController.dispose();
    super.dispose();
  }

  void _saatGulir() {
    if (_loadingMore || !_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.maxScrollExtent <= 0 || position.extentAfter > 160) return;
    _muatLebihBanyak();
  }

  Future<void> _muatLebihBanyak() async {
    final provider = context.read<PromoGameProvider>();
    final trending = _trending(provider);
    final adaLokal = _visibleCount < trending.length;
    final sekarang = DateTime.now();
    final bolehRefresh = _terakhirRefresh == null ||
        sekarang.difference(_terakhirRefresh!) > const Duration(seconds: 15);
    if (!adaLokal && !bolehRefresh) return;

    setState(() => _loadingMore = true);
    try {
      if (adaLokal) {
        await Future<void>.delayed(const Duration(milliseconds: 650));
        if (!mounted) return;
        setState(() {
          _visibleCount =
              (_visibleCount + _jumlahPerHalaman).clamp(0, trending.length);
        });
      } else {
        await provider.loadPromos();
        _terakhirRefresh = sekarang;
      }
    } finally {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

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
    final trending = _trending(provider);
    final trendingTampil = trending.take(_visibleCount).toList();
    final adaFilter =
        provider.query.trim().isNotEmpty || provider.platform != 'All';

    final signature =
        '${provider.query}|${provider.platform}|${trending.length}|${provider.promos.length}';
    if (signature != _signature) {
      _signature = signature;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (_visibleCount != _jumlahPerHalaman || _loadingMore) {
          setState(() {
            _visibleCount = _jumlahPerHalaman;
            _loadingMore = false;
          });
        }
      });
    }

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
        child: RefreshIndicator(
          color: const Color(0xFFBBF76A),
          backgroundColor: const Color(0xFF161D28),
          onRefresh: provider.loadPromos,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DiscoverHeader(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 96),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomSearchBar(onChanged: provider.setQuery),
                      const SizedBox(height: 20),
                      PlatformFilterRow(
                        selected: provider.platform,
                        onChanged: provider.setPlatform,
                      ),
                      const SizedBox(height: 12),
                      const CheapSharkSyncButton(),
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
                            onTap: (promo) =>
                                _bukaDetail(context, promo.idPromo),
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
                        else if (trendingTampil.isNotEmpty)
                          Column(
                            children: [
                              for (final promo in trendingTampil)
                                GestureDetector(
                                  onTap: () =>
                                      _bukaDetail(context, promo.idPromo),
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
                        if (_loadingMore)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFFBBF76A),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Memuat promo lainnya...',
                                  style: TextStyle(
                                    color: Color(0xFF97A3B5),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else if (trendingTampil.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Center(
                              child: Text(
                                _visibleCount < trending.length
                                    ? 'Gulir bawah untuk melihat lagi'
                                    : 'Semua promo sudah ditampilkan',
                                style: const TextStyle(
                                  color: Color(0xFF68768A),
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
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
