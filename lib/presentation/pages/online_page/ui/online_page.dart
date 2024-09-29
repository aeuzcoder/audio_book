import 'package:audio_app/domain/bloc/user_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnlinePage extends StatelessWidget {
  const OnlinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.books[0].title),
                  ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(UserAuthEvent());
                        FirebaseAuth.instance.signOut();
                      },
                      child: const Text('Sign Out'))
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
