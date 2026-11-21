import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_keys.dart';
import '../providers/promo_game_provider.dart';

class CheapSharkSyncButton extends StatelessWidget {
  const CheapSharkSyncButton({super.key});

  Future<void> _sinkron(BuildContext context) async {
    final provider = context.read<PromoGameProvider>();
    final hasil = await provider.syncFromCheapShark();
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          hasil == null
              ? (provider.error ?? 'Gagal sinkron dari CheapShark')
              : '${hasil.message} · ${hasil.ringkasan}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sinkron = context.select<PromoGameProvider, bool>((p) => p.syncing);

    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton.icon(
        onPressed: sinkron ? null : () => _sinkron(context),
        icon: sinkron
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFFBBF76A),
                ),
              )
            : const Icon(Icons.cloud_download_outlined, size: 17),
        label: Text(
          sinkron
              ? 'Mengambil diskon dari CheapShark...'
              : 'Sinkron diskon otomatis (CheapShark)',
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFBBF76A),
          side: const BorderSide(color: Color(0xFF4A5A36)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
