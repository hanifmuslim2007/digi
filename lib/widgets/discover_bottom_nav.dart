import 'package:flutter/material.dart';

class DiscoverBottomNav extends StatelessWidget {
  const DiscoverBottomNav({super.key});

  static const _items = [
    (label: 'Home', icon: Icons.home_outlined),
    (label: 'Wishlist', icon: Icons.favorite_border),
    (label: 'Alerts', icon: Icons.notifications_none),
    (label: 'Profile', icon: Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: const BoxDecoration(
          color: Color(0xFF0C1017),
          border: Border(top: BorderSide(color: Color(0xFF29323F))),
        ),
        child: Row(
          children: [
            for (var index = 0; index < _items.length; index++)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _items[index].icon,
                      size: 20,
                      color: index == 0
                          ? const Color(0xFFBBF76A)
                          : const Color(0xFF68768A),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _items[index].label,
                      style: TextStyle(
                        color: index == 0
                            ? const Color(0xFFBBF76A)
                            : const Color(0xFF68768A),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
