import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:lab7_coffee_lib/main.dart';
import 'package:lab7_coffee_lib/providers/cart_provider.dart';
import 'package:lab7_coffee_lib/providers/favorites_provider.dart';

void main() {
  testWidgets('App starts', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FavoritesProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
        child: const CoffeeApp(),
      ),
    );

    expect(find.text('Coffee Shop'), findsWidgets);
  });
}