import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:digi/main.dart';

void main() {
  testWidgets('discover opens game details and returns', (tester) async {
    await tester.pumpWidget(const DigiApp());

    expect(find.text('DISKON GAME'), findsOneWidget);
    expect(find.text('Top Deals'), findsOneWidget);
    expect(find.text('Trending Drops'), findsOneWidget);
    expect(find.byIcon(Icons.home_outlined), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.notifications_none), findsOneWidget);
    expect(find.byIcon(Icons.person_outline), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('game-search-field')),
      'Cyberpunk',
    );
    await tester.pump();

    expect(find.text('Cyberpunk 2077'), findsOneWidget);
    expect(find.text('God of War Ragnarök'), findsNothing);
    expect(find.text('Hogwarts Legacy'), findsNothing);
    await tester.enterText(find.byKey(const Key('game-search-field')), '');
    await tester.pump();

    await tester.tap(find.byKey(const Key('top-deal-card')));
    await tester.pumpAndSettle();

    expect(find.text('GAME DETAILS'), findsOneWidget);
    expect(find.text('Hogwarts Legacy'), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(find.text('DISKON GAME'), findsOneWidget);
  });
}
