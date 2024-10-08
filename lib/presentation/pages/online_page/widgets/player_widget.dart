import 'package:audio_app/core/theme/colors.dart';
import 'package:audio_app/data/models/book.dart';
import 'package:audio_app/presentation/pages/online_page/data/cubit/audio_player_cubit.dart';
import 'package:audio_app/presentation/pages/online_page/data/cubit/audio_player_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key, required this.state, required this.book});
  final AudioPlayerLoadingState state;
  final Book book;

  String nameOfChapter(int index) {
    if (index == 0) {
      return 'Kitob haqida';
    } else if (index == 1) {
      return 'Kirish';
    } else if (index == book.chapters.length - 1) {
      return 'Xulosa';
    } else {
      return '${index - 1} - Mavzu';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = context.read<AudioPlayerCubit>();

    return Column(
      children: [
        Text(
          state.nameOfChapter,
          style: const TextStyle(
            color: widgetColor,
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
        ),

        //P L A Y E R
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.textOfPosition()),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2.0,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 20.0),
                ),
                child: SizedBox(
                  width: size.width / 1.8,
                  child: Slider(
                    thumbColor: widgetColor,
                    activeColor: widgetColor,
                    min: 0.0,
                    max: state.lengthOfAudio.inSeconds.toDouble(),
                    value: state.position.inSeconds.toDouble(),
                    onChanged: (value) {
                      bloc.audioSeek(value);
                    },
                  ),
                ),
              ),
              Text(state.textOfLength()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  int index = state.chapterIndex - 1;
                  if (state.chapterIndex > 0) {
                    bloc.initializePlayer(
                        url: book.chapters[index],
                        chapterIndex: index,
                        bookIndex: bloc.bookIndex,
                        nameOfChapter: nameOfChapter(index),
                        nameOfBook: state.nameOfBook);
                  }
                },
                icon: Icon(
                  Icons.skip_previous_rounded,
                  size: 36,
                  color: fontColor.withOpacity(0.7),
                ),
              ),
              GestureDetector(
                onTap: () {
                  bloc.handlePlayPause();
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      color: widgetColor, shape: BoxShape.circle),
                  child: Icon(
                    state.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 32,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  int index = state.chapterIndex + 1;
                  if (state.chapterIndex < book.chapters.length - 1) {
                    bloc.initializePlayer(
                        url: book.chapters[index],
                        chapterIndex: index,
                        bookIndex: bloc.bookIndex,
                        nameOfChapter: nameOfChapter(index),
                        nameOfBook: state.nameOfBook);
                  }
                },
                icon: Icon(
                  Icons.skip_next_rounded,
                  size: 36,
                  color: fontColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
