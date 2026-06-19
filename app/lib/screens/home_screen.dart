import 'package:flutter/material.dart';
import '../widgets/empty_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SoleMuseum'),
        subtitle: Text(
          'Collect. Preserve. Showcase.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
      body: EmptyState(
        icon: Icons.home_outlined,
        title: 'Welcome to SoleMuseum',
        description: 'Start by adding your first shoe to your collection.',
      ),
    );
  }
}
