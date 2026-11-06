import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;

  // The catalog (global `coffees` list) is still local state of the Feed.
  void _refresh() => setState(() {});

  /// Icon with a live counter badge (hidden when the count is 0).
  Widget _badged(IconData icon, int count) => Badge(
    isLabelVisible: count > 0,
    label: Text('$count'),
    child: Icon(icon),
  );

  @override
  Widget build(BuildContext context) {
    // Persistent counts on tabs: watch both providers.
    final favCount = context.watch<FavoritesProvider>().count;
    final cartCount = context.watch<CartProvider>().totalCount;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(onChanged: _refresh),
          const FavoritesScreen(),
          const CartScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe_outlined),
            activeIcon: Icon(Icons.local_cafe),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: _badged(Icons.favorite_border, favCount),
            activeIcon: _badged(Icons.favorite, favCount),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: _badged(Icons.shopping_cart_outlined, cartCount),
            activeIcon: _badged(Icons.shopping_cart, cartCount),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}