import 'package:flutter/material.dart';

import '../screens/shoe_form_screen.dart';

class AppFab extends StatelessWidget {
  const AppFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      tooltip: 'スニーカーを収蔵する',
      icon: const Icon(Icons.inventory_2_outlined),
      label: const Text(
        '収蔵する',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ShoeFormScreen()),
        );
      },
    );
  }
}
