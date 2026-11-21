import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'config/app_keys.dart';
import 'pages/discover_page.dart';
import 'providers/promo_game_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID');
  runApp(const DigiApp());
}

class DigiApp extends StatelessWidget {
  const DigiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PromoGameProvider()..loadPromos(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
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
      ),
    );
  }
}
