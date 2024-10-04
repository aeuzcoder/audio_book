import 'package:audio_app/core/theme/colors.dart';
import 'package:audio_app/data/models/book.dart';
import 'package:audio_app/presentation/pages/online_page/pages/home_page/home_page.dart';
import 'package:audio_app/presentation/pages/online_page/pages/library_page/library_page.dart';
import 'package:audio_app/presentation/pages/online_page/pages/profile_page/profile_page.dart';
import 'package:audio_app/presentation/pages/online_page/pages/search_page/search_page.dart';
import 'package:audio_app/presentation/pages/online_page/widgets/floating_action_widget.dart';
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: index != 3
            ? FloatingActionWidget(
                book: widget.books.first,
              )
            : null,
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

      //      BODY
      body: <Widget>[
        HomePage(books: widget.books),
        SearchPage(books: widget.books),
        const LiblaryPage(),
        const ProfilePage()
      ][index],
    );
  }
}
