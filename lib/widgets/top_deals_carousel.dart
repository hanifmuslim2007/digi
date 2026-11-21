import 'dart:async';

import 'package:flutter/material.dart';

import '../models/promo_game.dart';
import 'top_deal_card.dart';

class TopDealsCarousel extends StatefulWidget {
  const TopDealsCarousel({
    super.key,
    required this.promos,
    required this.onTap,
  });

  final List<PromoGame> promos;
  final ValueChanged<PromoGame> onTap;

  @override
  State<TopDealsCarousel> createState() => _TopDealsCarouselState();
}

class _TopDealsCarouselState extends State<TopDealsCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.92);
  Timer? _timer;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _mulaiAutoGeser();
  }

  @override
  void didUpdateWidget(TopDealsCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.promos.length != widget.promos.length) {
      _timer?.cancel();
      _current = 0;
      _mulaiAutoGeser();
    }
  }

  void _mulaiAutoGeser() {
    if (widget.promos.length < 2) return;
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || !_controller.hasClients) return;
      final halaman = _controller.page?.round() ?? _current;
      final berikutnya = (halaman + 1) % widget.promos.length;
      _controller.animateToPage(
        berikutnya,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.promos.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 248,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.promos.length,
            onPageChanged: (index) => setState(() => _current = index),
            itemBuilder: (context, index) {
              final promo = widget.promos[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: () => widget.onTap(promo),
                  child: TopDealCard(promo: promo),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var index = 0; index < widget.promos.length; index++)
              GestureDetector(
                onTap: () => _controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: index == _current ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: index == _current
                        ? const Color(0xFFBBF76A)
                        : const Color(0xFF29323F),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
