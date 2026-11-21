import 'package:flutter/material.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({super.key});

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
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF161D28),
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
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFBBF76A),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Buy on Steam',
                  style: TextStyle(color: Color(0xFF13200D), fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
