import 'package:flutter/material.dart';

/// Palet warna DiGi yang mengikuti brightness tema (dark / light).
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.border,
    required this.text,
    required this.textMuted,
    required this.textSubtle,
    required this.accent,
    required this.onAccent,
    required this.danger,
    required this.dangerSoft,
    required this.outline,
  });

  final Color background;
  final Color surface;
  final Color surfaceAlt;
  final Color border;
  final Color text;
  final Color textMuted;
  final Color textSubtle;
  final Color accent;
  final Color onAccent;
  final Color danger;
  final Color dangerSoft;
  final Color outline;

  static const dark = AppPalette(
    background: Color(0xFF0C1017),
    surface: Color(0xFF161D28),
    surfaceAlt: Color(0xFF202936),
    border: Color(0xFF29323F),
    text: Color(0xFFF6F7FB),
    textMuted: Color(0xFF97A3B5),
    textSubtle: Color(0xFF68768A),
    accent: Color(0xFFBBF76A),
    onAccent: Color(0xFF13200D),
    danger: Color(0xFFE06B6B),
    dangerSoft: Color(0xFFF6C4C4),
    outline: Color(0xFF4A5A36),
  );

  static const light = AppPalette(
    background: Color(0xFFF6F7FB),
    surface: Color(0xFFFFFFFF),
    surfaceAlt: Color(0xFFEEF1F6),
    border: Color(0xFFDDE3EB),
    text: Color(0xFF121820),
    textMuted: Color(0xFF5B687C),
    textSubtle: Color(0xFF7A8798),
    accent: Color(0xFF437A08),
    onAccent: Color(0xFFFFFFFF),
    danger: Color(0xFFC0392B),
    dangerSoft: Color(0xFF7A1F1F),
    outline: Color(0xFFB7CFA0),
  );

  @override
  AppPalette copyWith({
    Color? background,
    Color? surface,
    Color? surfaceAlt,
    Color? border,
    Color? text,
    Color? textMuted,
    Color? textSubtle,
    Color? accent,
    Color? onAccent,
    Color? danger,
    Color? dangerSoft,
    Color? outline,
  }) {
    return AppPalette(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      border: border ?? this.border,
      text: text ?? this.text,
      textMuted: textMuted ?? this.textMuted,
      textSubtle: textSubtle ?? this.textSubtle,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      danger: danger ?? this.danger,
      dangerSoft: dangerSoft ?? this.dangerSoft,
      outline: outline ?? this.outline,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceAlt: Color.lerp(surfaceAlt, other.surfaceAlt, t)!,
      border: Color.lerp(border, other.border, t)!,
      text: Color.lerp(text, other.text, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textSubtle: Color.lerp(textSubtle, other.textSubtle, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      dangerSoft: Color.lerp(dangerSoft, other.dangerSoft, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
    );
  }
}

extension AppPaletteContext on BuildContext {
  AppPalette get palette =>
      Theme.of(this).extension<AppPalette>() ?? AppPalette.dark;
}

class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFBBF76A),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppPalette.dark.background,
      extensions: const <ThemeExtension<dynamic>>[AppPalette.dark],
    );
  }

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF437A08),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppPalette.light.background,
      extensions: const <ThemeExtension<dynamic>>[AppPalette.light],
    );
  }
}
