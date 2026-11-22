import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, this.onChanged});

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: ShapeDecoration(
        color: context.palette.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: context.palette.border),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: context.palette.textMuted, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              key: const Key('game-search-field'),
              onChanged: onChanged,
              style: TextStyle(color: context.palette.text, fontSize: 13),
              cursorColor: context.palette.accent,
              decoration: InputDecoration(
                hintText: 'Find your next game',
                hintStyle: TextStyle(color: context.palette.textMuted, fontSize: 13),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 20,
            child: VerticalDivider(
              width: 1,
              thickness: 1,
              color: context.palette.border,
            ),
          ),
          const SizedBox(width: 10),
          Icon(Icons.tune, color: context.palette.textMuted, size: 18),
        ],
      ),
    );
  }
}
