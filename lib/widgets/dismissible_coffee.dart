import 'package:flutter/material.dart';

import '../models/coffee.dart';


class DismissibleCoffee extends StatelessWidget {
  final Coffee coffee;
  final Widget child;
  final VoidCallback onDismissed;
  final BorderRadius borderRadius;

  const DismissibleCoffee({
    super.key,
    required this.coffee,
    required this.child,
    required this.onDismissed,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(coffee.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismissed(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: borderRadius,
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 32),
      ),
      child: child,
    );
  }
}