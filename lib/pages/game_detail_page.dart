import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_keys.dart';
import '../models/promo_game.dart';
import '../providers/promo_game_provider.dart';
import '../widgets/bottom_action_bar.dart';
import '../widgets/game_detail_header.dart';
import '../widgets/price_history_chart.dart';
import '../widgets/store_comparison_card.dart';
import 'promo_form_page.dart';

class GameDetailPage extends StatelessWidget {
  const GameDetailPage({super.key, required this.idPromo});

  final int idPromo;

  Future<void> _ubah(BuildContext context, PromoGame promo) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => PromoFormPage(promo: promo)),
    );
  }

  Future<void> _hapus(BuildContext context, PromoGame promo) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF161D28),
        title: const Text(
          'Hapus promo?',
          style: TextStyle(color: Color(0xFFF6F7FB), fontSize: 18),
        ),
        content: Text(
          'Promo ${promo.namaGame} akan dihapus dari database.',
          style: const TextStyle(color: Color(0xFF97A3B5), fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFE06B6B),
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (konfirmasi != true || !context.mounted) return;

    final berhasil = await context.read<PromoGameProvider>().deletePromo(idPromo);
    if (!context.mounted) return;
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          berhasil
              ? 'Promo ${promo.namaGame} berhasil dihapus'
              : 'Gagal menghapus promo',
        ),
      ),
    );
    if (berhasil) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PromoGameProvider>();
    final hasil = provider.promos.where((p) => p.idPromo == idPromo).toList();

    if (provider.loading && hasil.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF0C1017),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFBBF76A)),
        ),
      );
    }
    if (hasil.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF0C1017),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Promo tidak ditemukan',
                style: TextStyle(color: Color(0xFFF6F7FB)),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      );
    }

    final promo = hasil.first;
    final kedaluwarsa = promo.isKedaluwarsa || !promo.isAktif;

    return Scaffold(
      backgroundColor: const Color(0xFF0C1017),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GameDetailHeader(
                imageUrl: promo.gambarGame,
                genre: promo.genre,
                batasPromo: promo.formatBatasPromo,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      promo.namaGame,
                      style: const TextStyle(
                        color: Color(0xFFF6F7FB),
                        fontSize: 31,
                        fontWeight: FontWeight.w400,
                        height: 1.1,
                        letterSpacing: -1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${promo.platform}${promo.genre.isEmpty ? '' : ' · ${promo.genre}'}',
                      style: const TextStyle(
                        color: Color(0xFF97A3B5),
                        fontSize: 11,
                      ),
                    ),
                    if (kedaluwarsa)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0x33E06B6B),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            promo.isAktif ? 'Promo kedaluwarsa' : 'Promo nonaktif',
                            style: const TextStyle(
                              color: Color(0xFFF6C4C4),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  promo.formatHargaDiskon,
                                  style: const TextStyle(
                                    color: Color(0xFFF6F7FB),
                                    fontSize: 40,
                                    fontWeight: FontWeight.w800,
                                    height: 1.1,
                                    letterSpacing: -2,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  promo.formatHargaAwal,
                                  style: const TextStyle(
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
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _ubah(context, promo),
                            icon: const Icon(Icons.edit_outlined, size: 16),
                            label: const Text('Ubah Promo'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFF6F7FB),
                              side: const BorderSide(color: Color(0xFF29323F)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _hapus(context, promo),
                            icon: const Icon(Icons.delete_outline, size: 16),
                            label: const Text('Hapus'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFE06B6B),
                              side: const BorderSide(color: Color(0x66E06B6B)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (promo.deskripsi.isNotEmpty) ...[
                      const SizedBox(height: 18),
                      Text(
                        promo.deskripsi,
                        style: const TextStyle(
                          color: Color(0xFF97A3B5),
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],
                    const SizedBox(height: 22),
                    StoreComparisonCard(
                      platform: promo.platform,
                      hargaDiskon: promo.formatHargaDiskon,
                      hargaAwal: promo.formatHargaAwal,
                    ),
                    const SizedBox(height: 22),
                    PriceHistoryChart(
                      hargaAwal: promo.hargaAwal,
                      hargaDiskon: promo.hargaDiskon,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(platform: promo.platform),
    );
  }
}
