import 'package:flutter/material.dart';

import '../config/app_theme.dart';
import 'discover_page.dart';

/// Tampilan awal aplikasi memakai DIGI / Mark dari FigCraft.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(Duration(milliseconds: 1400), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const DiscoverPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final pal = context.palette;
    return Scaffold(
      backgroundColor: pal.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/brand/digi_mark_320.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 16),
            Text(
              'digi',
              style: TextStyle(
                color: pal.text,
                fontSize: 34,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.5,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: 26,
              height: 26,
              child: CircularProgressIndicator(
                color: pal.accent,
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
