import 'package:flutter/material.dart';

class OnlinePage extends StatelessWidget {
  const OnlinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'ONLINE PAGE',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
