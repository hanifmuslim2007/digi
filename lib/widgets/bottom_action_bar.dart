import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/app_keys.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
    required this.platform,
    required this.storeUrl,
    this.onWishlist,
  });

  final String platform;
  final String storeUrl;
  final VoidCallback? onWishlist;

  Future<void> _bukaToko() async {
    final uri = Uri.tryParse(storeUrl);
    if (uri == null || !uri.hasScheme) {
      _gagal('Link toko tidak valid');
      return;
    }
    try {
      final bisaDibuka = await canLaunchUrl(uri) ||
          await canLaunchUrl(uri.replace(scheme: 'https'));
      if (!bisaDibuka) {
        _gagal('Tidak dapat membuka toko $platform');
        return;
      }
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      _gagal('Tidak dapat membuka toko $platform');
    }
  }

  void _gagal(String pesan) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(pesan)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 14, 24, 14),
        decoration: const BoxDecoration(
          color: Color(0xFF0C1017),
          border: Border(top: BorderSide(color: Color(0xFF29323F))),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Material(
                color: const Color(0xFF161D28),
                borderRadius: BorderRadius.circular(14),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onWishlist,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF29323F)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Add to Wishlist',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Color(0xFFF6F7FB), fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Material(
                color: const Color(0xFFBBF76A),
                borderRadius: BorderRadius.circular(14),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: _bukaToko,
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'Buy on $platform',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF13200D),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.open_in_new,
                          size: 14,
                          color: Color(0xFF13200D),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
