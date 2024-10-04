import 'package:audio_app/core/theme/colors.dart';
import 'package:audio_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
          title: 'Profile',
          colorTitle: widgetColor,
          colorBg: Colors.transparent,
          colorFg: fontColor),
      body: Center(
        child: Text('PROFILE'),
      ),
    );
  }
}
