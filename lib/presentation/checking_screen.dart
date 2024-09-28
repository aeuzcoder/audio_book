import 'package:audio_app/presentation/bloc/user_bloc.dart';
import 'package:audio_app/presentation/pages/auth_page/auth_page.dart';
import 'package:audio_app/presentation/pages/offline_page/ui/offline_page.dart';
import 'package:audio_app/presentation/pages/online_page/ui/online_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckingScreen extends StatelessWidget {
  const CheckingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        //Opens when the app opens
        if (state is UserStartState) {}

        //Opens when user didn't authentificate
        if (state is UserAuthState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthPage(),
            ),
          );
        }

        //Opens when data is loading
        if (state is UserLoadingState) {}

        //Opens when user is offline

        if (state is UserOfflineState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OfflinePage(),
            ),
          );
        }
        //Opens when user is online
        if (state is UserOnlineState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OnlinePage(),
            ),
          );
        }
      },
      child: const Scaffold(),
    );
  }
}
