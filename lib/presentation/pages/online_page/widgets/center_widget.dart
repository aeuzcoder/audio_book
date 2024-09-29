import 'package:audio_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CenterWidget extends StatelessWidget {
  CenterWidget({super.key});
  final List<String> category = [
    'Thriller',
    'Suspense',
    'Humour',
    'Comedy',
    'Drama',
    'Romantic'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 64,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: category.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    color: widgetColor.withOpacity(0.5),
                    child: Center(
                      child: Text(
                        category[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
