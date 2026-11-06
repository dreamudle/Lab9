import 'package:flutter/foundation.dart';

import '../models/coffee.dart';

class CartItem {
  final Coffee coffee;
  final int quantity;

  const CartItem({required this.coffee, required this.quantity});

  double get subtotal => coffee.price * quantity;

  CartItem copyWith({int? quantity}) =>
      CartItem(coffee: coffee, quantity: quantity ?? this.quantity);
}

class CartProvider extends ChangeNotifier {
  final Map<int, CartItem> _lines = {};

  List<CartItem> get items => List.unmodifiable(_lines.values);

  int get totalCount => _lines.values.fold(0, (sum, l) => sum + l.quantity);

  double get totalPrice =>
      _lines.values.fold(0.0, (sum, l) => sum + l.subtotal);

  void add(Coffee coffee, {int quantity = 1}) {
    final existing = _lines[coffee.id];
    _lines[coffee.id] = existing == null
        ? CartItem(coffee: coffee, quantity: quantity)
        : existing.copyWith(quantity: existing.quantity + quantity);
    notifyListeners();
  }

  void increment(int coffeeId) {
    final line = _lines[coffeeId];
    if (line == null) return;
    _lines[coffeeId] = line.copyWith(quantity: line.quantity + 1);
    notifyListeners();
  }

  void decrement(int coffeeId) {
    final line = _lines[coffeeId];
    if (line == null) return;
    if (line.quantity <= 1) {
      _lines.remove(coffeeId);
    } else {
      _lines[coffeeId] = line.copyWith(quantity: line.quantity - 1);
    }
    notifyListeners();
  }

  void remove(int coffeeId) {
    if (_lines.remove(coffeeId) != null) notifyListeners();
  }

  void clear() {
    if (_lines.isEmpty) return;
    _lines.clear();
    notifyListeners();
  }
}