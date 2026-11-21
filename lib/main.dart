import 'package:flutter/material.dart';

import 'pages/discover_page.dart';

void main() {
  runApp(const DigiApp());
}

class DigiApp extends StatelessWidget {
  const DigiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0C1017),
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF0C1017),
          primary: Color(0xFFBBF76A),
        ),
        useMaterial3: true,
      ),
      home: const DiscoverPage(),
    );
  }
}
