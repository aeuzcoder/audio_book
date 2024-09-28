import 'package:flutter/material.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'OFFLINE PAGE',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
