import 'package:audio_app/core/theme/colors.dart';
import 'package:audio_app/core/widgets/custom_app_bar.dart';
import 'package:audio_app/data/models/book.dart';
import 'package:audio_app/presentation/pages/online_page/widgets/bottom_widget.dart';
import 'package:audio_app/presentation/pages/online_page/widgets/center_widget.dart';
import 'package:audio_app/presentation/pages/online_page/widgets/top_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.books});
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Explore',
        colorTitle: widgetColor,
        colorBg: Colors.transparent,
        colorFg: fontColor,
      ),
      body: Padding(
        //ALL SCREEN PADDING
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              //WIDGETS
              children: [
                TopWidget(books: books),
                CenterWidget(),
                BottomWidget(books: books),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
