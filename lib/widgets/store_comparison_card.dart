import 'package:flutter/material.dart';

class StoreComparisonCard extends StatelessWidget {
  const StoreComparisonCard({
    super.key,
    required this.platform,
    required this.hargaDiskon,
    required this.hargaAwal,
  });

  final String platform;
  final String hargaDiskon;
  final String hargaAwal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFF161D28),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF29323F)),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          const Text(
            'HARGA PROMO',
            style: TextStyle(
              color: Color(0xFF97A3B5),
              fontSize: 9,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.30,
            ),
          ),
          _HargaBaris(
            icon: Icons.store,
            label: platform,
            keterangan: 'Harga diskon',
            harga: hargaDiskon,
            hargaColor: const Color(0xFFBBF76A),
          ),
          const Divider(height: 1, color: Color(0xFF29323F)),
          _HargaBaris(
            icon: Icons.local_offer_outlined,
            label: 'Harga awal',
            keterangan: 'Sebelum diskon',
            harga: hargaAwal,
            hargaColor: const Color(0xFFF6F7FB),
          ),
        ],
      ),
    );
  }
}

class _HargaBaris extends StatelessWidget {
  const _HargaBaris({
    required this.icon,
    required this.label,
    required this.keterangan,
    required this.harga,
    required this.hargaColor,
  });

  final IconData icon;
  final String label;
  final String keterangan;
  final String harga;
  final Color hargaColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Row(
        spacing: 10,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: ShapeDecoration(
              color: const Color(0xFF202936),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Center(child: Icon(icon, color: Colors.white, size: 16)),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 3,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFFF6F7FB),
                    fontSize: 13,
                  ),
                ),
                Text(
                  keterangan,
                  style: const TextStyle(
                    color: Color(0xFF97A3B5),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Text(
            harga,
            style: TextStyle(color: hargaColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
