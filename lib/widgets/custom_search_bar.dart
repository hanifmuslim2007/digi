import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, this.onChanged});

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: ShapeDecoration(
        color: const Color(0xFF161D28),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFF29323F)),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF97A3B5), size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              key: const Key('game-search-field'),
              onChanged: onChanged,
              style: const TextStyle(color: Color(0xFFF6F7FB), fontSize: 13),
              cursorColor: const Color(0xFFBBF76A),
              decoration: const InputDecoration(
                hintText: 'Find your next game',
                hintStyle: TextStyle(color: Color(0xFF97A3B5), fontSize: 13),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const SizedBox(
            height: 20,
            child: VerticalDivider(
              width: 1,
              thickness: 1,
              color: Color(0xFF29323F),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.tune, color: Color(0xFF97A3B5), size: 18),
        ],
      ),
    );
  }
}
