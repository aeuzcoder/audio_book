import 'package:audio_app/core/theme/colors.dart';
import 'package:audio_app/presentation/pages/online_page/widgets/bottom_widget.dart';
import 'package:audio_app/presentation/pages/online_page/widgets/center_widget.dart';
import 'package:audio_app/presentation/pages/online_page/widgets/top_widget.dart';
import 'package:audio_app/domain/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnlinePage extends StatefulWidget {
  const OnlinePage({super.key});

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
        onPressed: () {},
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: fontColor,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.more_vert,
              size: 32,
            ),
          )
        ],
        title: Text(
          'Explore',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: widgetColor),
        ),
      ),

      //      BODY
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            final books = state.books;
            return Padding(
              //ALL SCREEN PADDING
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
