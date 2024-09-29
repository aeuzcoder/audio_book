import 'package:audio_app/core/theme/colors.dart';
import 'package:audio_app/domain/bloc/user_bloc.dart';
import 'package:audio_app/presentation/pages/login_page/login_page.dart';
import 'package:audio_app/presentation/pages/offline_page/ui/offline_page.dart';
import 'package:audio_app/presentation/pages/online_page/ui/online_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckingScreen extends StatelessWidget {
  const CheckingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        //Opens when user didn't authentificate
        if (state is UserAuthState) {
          return const LoginPage();
        }

        //Opens when user is offline
        else if (state is UserOfflineState) {
          return const OfflinePage();
        }

        //Opens when user is online
        else if (state is UserLoadedState) {
          return const OnlinePage();
        }

        //Opens when data is loading
        else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: widgetColor,
                strokeWidth: 3,
              ),
            ),
          );
        }
      },
    );
  }
}
