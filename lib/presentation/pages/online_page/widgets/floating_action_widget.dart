import 'package:audio_app/core/theme/colors.dart';
import 'package:audio_app/data/models/book.dart';
import 'package:audio_app/presentation/pages/online_page/data/cubit/audio_player_cubit.dart';
import 'package:audio_app/presentation/pages/online_page/data/cubit/audio_player_state.dart';
import 'package:audio_app/presentation/pages/online_page/ui/player_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FloatingActionWidget extends StatelessWidget {
  const FloatingActionWidget({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AudioPlayerCubit>();
    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
      builder: (context, state) {
        //AUDIO PLAYER LOADING
        if (state is AudioPlayerLoadingState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        bloc.handlePlayPause();
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: widgetColor, width: 1.6),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            state.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: widgetColor,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.6,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlayerPage(
                                        checkingBook: true,
                                        book: book,
                                        bookIndex: context
                                            .read<AudioPlayerCubit>()
                                            .bookIndex,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(state.nameOfChapter,
                                    style: const TextStyle(
                                        fontSize: 20, color: fontColor)),
                              ),
                              Text(state.nameOfBook,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: fontColor.withOpacity(0.6))),
                            ],
                          ),
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 2.0,
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 8.0),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 0.0),
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.8,
                            child: Slider(
                              thumbColor: widgetColor,
                              activeColor: widgetColor,
                              inactiveColor: Colors.grey.withOpacity(0.6),
                              min: 0.0,
                              max: state.lengthOfAudio.inSeconds.toDouble(),
                              value: state.position.inSeconds.toDouble(),
                              onChanged: (value) {
                                context
                                    .read<AudioPlayerCubit>()
                                    .audioSeek(value);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

        //AUDIO PLAYER INITIAL
        else if (state is AudioPlayerInitial) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        bloc.initializePlayer(
                            url: book.chapters.first,
                            chapterIndex: book.chapters.length - 1,
                            bookIndex: 0,
                            nameOfChapter: 'Kitob haqida',
                            nameOfBook: book.title);
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.6),
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.play_arrow,
                            color: widgetColor,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.6,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('AUDIO BOOK',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700)),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 2.0,
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 8.0),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 8.0),
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.8,
                            child: Slider(
                              thumbColor: widgetColor,
                              activeColor: widgetColor,
                              inactiveColor: Colors.grey.withOpacity(0.6),
                              min: 0.0,
                              max: 10.0,
                              value: 0,
                              onChanged: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
