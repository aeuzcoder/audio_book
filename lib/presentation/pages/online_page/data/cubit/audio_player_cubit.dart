import 'dart:developer';

import 'package:audio_app/presentation/pages/online_page/data/cubit/audio_player_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayerCubit() : super(AudioPlayerInitial());
  AudioPlayer? player;
  bool isPlaying = false;
  int bookIndex = 0;
  String nameOfChapter = 'Kirish';
  bool checkingForFirstTime = true;

  Future<Duration?> lengthOfFirstAudio(String url) async {
    final AudioPlayer playerForView = AudioPlayer();
    try {
      await playerForView.setUrl(url);
      Duration? length = await playerForView.durationStream.firstWhere(
        (duration) => duration != null,
      );
      return length;
    } catch (e) {
      // Обработка ошибок при загрузке
      log('Error loading audio length: $e');
      return null;
    } finally {
      await playerForView.dispose();
    }
  }

  // For loading audio
  void initializePlayer({
    required String url,
    required int chapterIndex,
    required int bookIndex,
    required String nameOfChapter,
  }) async {
    this.bookIndex = bookIndex;

    // Очищаем предыдущий плеер, если он существует
    if (player != null) {
      await _clearPlayer();
    }

    try {
      player = AudioPlayer();
      await player!.setUrl(url);
      await player!.load();

      emit(
        AudioPlayerLoadingState(
          position: Duration.zero,
          lengthOfAudio: Duration.zero,
          isPlaying: isPlaying,
          nameOfChapter: nameOfChapter,
          chapterIndex: chapterIndex,
        ),
      );

      _listenPosition();
    } catch (e) {
      // Обработка ошибки при инициализации плеера
      log('Error initializing player: $e');
    }
  }

  void _listenPosition() {
    player!.positionStream.listen((position) {
      if (state is AudioPlayerLoadingState) {
        emit((state as AudioPlayerLoadingState).copyWith(position: position));
      }
    });

    player!.durationStream.listen((duration) {
      if (duration != null && state is AudioPlayerLoadingState) {
        emit((state as AudioPlayerLoadingState)
            .copyWith(lengthOfAudio: duration));
      }
    });

    player!.playerStateStream.listen(
      (playerState) {
        if (player!.processingState == ProcessingState.completed) {
          player!.seek(Duration.zero);
          player!.pause();
          emit((state as AudioPlayerLoadingState)
              .copyWith(isPlaying: false, position: Duration.zero));
        }
      },
    );
  }

  void handlePlayPause() {
    if (player != null && player!.playing) {
      player!.pause();
      emit((state as AudioPlayerLoadingState).copyWith(isPlaying: false));
    } else {
      player!.play();
      emit((state as AudioPlayerLoadingState).copyWith(isPlaying: true));
    }
  }

  void audioSeek(double value) {
    if (player != null) {
      player!.seek(Duration(seconds: value.toInt()));
      emit((state as AudioPlayerLoadingState)
          .copyWith(position: Duration(seconds: value.toInt())));
    }
  }

  Future<void> _clearPlayer() async {
    if (player != null) {
      await player!.stop();
      await player!.dispose();
      player = null;
    }
  }

  @override
  Future<void> close() {
    _clearPlayer();
    return super.close();
  }
}
