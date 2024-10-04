import 'package:audio_app/core/theme/colors.dart';
import 'package:audio_app/core/widgets/custom_app_bar.dart';
import 'package:audio_app/data/models/book.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key, required this.books});
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
            title: 'Library',
            colorTitle: widgetColor,
            colorBg: Colors.transparent,
            colorFg: fontColor),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: TextField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.withOpacity(0.6),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: widgetColor, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: widgetColor, width: 1)),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
