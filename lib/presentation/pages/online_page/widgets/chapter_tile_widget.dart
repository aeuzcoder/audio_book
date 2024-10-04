import 'package:audio_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class ChapterTileWidget extends StatelessWidget {
  const ChapterTileWidget({
    super.key,
    required this.isPlaying,
    required this.indexChapter,
    required this.title,
    required this.onTap,
    required this.endOfChapter,
  });
  final bool isPlaying;
  final int indexChapter;
  final String title;
  final VoidCallback onTap;
  final int endOfChapter;

  String textOfChapter(int index) {
    if (index == 0) {
      return 'Kitob haqida';
    } else if (index == 1) {
      return 'Kirish';
    } else if (index == endOfChapter - 1) {
      return 'Xulosa';
    } else {
      return '${index - 1} - Mavzu';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: isPlaying ? Colors.grey.withOpacity(0.2) : null,
          border: const Border(
            bottom: BorderSide(width: 0.2, color: fontColor),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 32,
                color: widgetColor,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            FittedBox(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.6,
                child: Text(
                  textOfChapter(indexChapter),
                  style: const TextStyle(color: fontColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
