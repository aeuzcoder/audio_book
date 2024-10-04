import 'package:audio_app/core/theme/colors.dart';
import 'package:audio_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class LiblaryPage extends StatelessWidget {
  const LiblaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
          title: 'Library',
          colorTitle: widgetColor,
          colorBg: Colors.transparent,
          colorFg: fontColor),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Center(
          child: Text('Library'),
        ),
      ),
    );
  }
}
