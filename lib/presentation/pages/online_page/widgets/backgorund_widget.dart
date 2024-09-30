import 'dart:ui';

import 'package:audio_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class BackgorundWidget extends StatelessWidget {
  const BackgorundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const Alignment(0.8, -1),
          child: Container(
            width: 260,
            height: 260,
            decoration: const BoxDecoration(
              color: widgetColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Align(
          alignment: const Alignment(-0.8, -0.6),
          child: Container(
            width: 260,
            height: 260,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 80,
            sigmaY: 80,
          ),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
