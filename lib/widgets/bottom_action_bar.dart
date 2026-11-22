import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/app_keys.dart';
import '../config/app_theme.dart';

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
        padding: EdgeInsets.fromLTRB(24, 14, 24, 14),
        decoration: BoxDecoration(
          color: context.palette.background,
          border: Border(top: BorderSide(color: context.palette.border)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Material(
                color: context.palette.surface,
                borderRadius: BorderRadius.circular(14),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onWishlist,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: context.palette.border),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Add to Wishlist',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: context.palette.text, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Material(
                color: context.palette.accent,
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
                            style: TextStyle(
                              color: context.palette.onAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.open_in_new,
                          size: 14,
                          color: context.palette.onAccent,
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
