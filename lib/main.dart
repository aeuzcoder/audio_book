import 'package:audio_app/domain/bloc/user_bloc.dart';
import 'package:audio_app/core/theme/custom_theme.dart';
import 'package:audio_app/presentation/checking_screen.dart';
import 'package:audio_app/presentation/pages/online_page/data/cubit/audio_player_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AudioPlayerCubit(),
        ),
        BlocProvider(
          create: (context) => UserBloc()..add(UserAuthEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: customTheme(),
        home: const CheckingScreen(),
      ),
    );
  }
}
