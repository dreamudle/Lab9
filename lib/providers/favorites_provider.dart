import 'package:flutter/foundation.dart';

import '../models/coffee.dart';

class FavoritesProvider extends ChangeNotifier {
  final Map<int, Coffee> _items = {};

  List<Coffee> get items => List.unmodifiable(_items.values);
  int get count => _items.length;

  bool isFavorite(int coffeeId) => _items.containsKey(coffeeId);

  void toggle(Coffee coffee) {
    if (_items.containsKey(coffee.id)) {
      _items.remove(coffee.id);
    } else {
      _items[coffee.id] = coffee;
    }
    notifyListeners();
  }
}
