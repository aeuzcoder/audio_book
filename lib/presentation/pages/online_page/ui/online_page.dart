import 'package:audio_app/core/theme/colors.dart';
import 'package:audio_app/core/widgets/custom_app_bar.dart';
import 'package:audio_app/data/models/book.dart';
import 'package:audio_app/presentation/pages/online_page/ui/player_page.dart';
import 'package:audio_app/presentation/pages/online_page/widgets/bottom_widget.dart';
import 'package:audio_app/presentation/pages/online_page/widgets/center_widget.dart';
import 'package:audio_app/presentation/pages/online_page/widgets/top_widget.dart';
import 'package:flutter/material.dart';

class OnlinePage extends StatefulWidget {
  const OnlinePage({super.key, required this.books});
  final List<Book> books;

  @override
  State<OnlinePage> createState() => _OnlinePageState();
}

class _OnlinePageState extends State<OnlinePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //FAB
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: widgetColor,
        foregroundColor: fontColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return PlayerPage(
                books: widget.books,
              );
            },
          ));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: const Icon(
          Icons.play_arrow,
          size: 36,
        ),
      ),

      //BOTTOM NAV BAR
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: widgetColor.withOpacity(0.2),
              offset: const Offset(0, 0),
              blurRadius: 5,
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashFactory:
                NoSplash.splashFactory, // Disable splash/ripple effect
            highlightColor:
                Colors.transparent, // Remove the white highlight glow
          ),
          child: BottomNavigationBar(
            iconSize: 28,
            enableFeedback: false,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            currentIndex: index,
            type: BottomNavigationBarType.fixed,
            backgroundColor: bgColor,
            selectedItemColor: widgetColor,
            elevation: 0,
            unselectedItemColor: Colors.grey.withOpacity(0.7),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Library'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      ),

      //APP BAR
      appBar: const CustomAppBar(
        title: 'Explore',
        colorTitle: widgetColor,
        colorBg: Colors.transparent,
        colorFg: fontColor,
      ),

      //      BODY
      body: Padding(
        //ALL SCREEN PADDING
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            //WIDGETS
            children: [
              TopWidget(books: widget.books),
              CenterWidget(),
              BottomWidget(books: widget.books),
            ],
          ),
        ),
      ),
    );
  }
}
