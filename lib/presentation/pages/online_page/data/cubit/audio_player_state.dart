sealed class AudioPlayerState {
  const AudioPlayerState();
}

final class AudioPlayerInitial extends AudioPlayerState {}

final class AudioPlayerLoadedState extends AudioPlayerState {
  final Duration position;
  final Duration lengthOfAudio;
  final bool isPlaying;
  final int chapterIndex;

  AudioPlayerLoadedState({
    required this.position,
    required this.lengthOfAudio,
    required this.isPlaying,
    required this.chapterIndex,
  });
}

final class AudioPlayerLoadingState extends AudioPlayerState {
  final Duration position;
  final Duration lengthOfAudio;
  final bool isPlaying;
  final int chapterIndex;
  final String nameOfChapter;
  final String nameOfBook;

  AudioPlayerLoadingState({
    required this.nameOfChapter,
    required this.position,
    required this.lengthOfAudio,
    required this.isPlaying,
    required this.chapterIndex,
    required this.nameOfBook,
  });

  AudioPlayerLoadingState copyWith({
    Duration? position,
    Duration? lengthOfAudio,
    bool? isPlaying,
    int? chapterIndex,
    String? nameOfChapter,
    String? nameOfBook,
  }) {
    return AudioPlayerLoadingState(
        position: position ?? this.position,
        lengthOfAudio: lengthOfAudio ?? this.lengthOfAudio,
        isPlaying: isPlaying ?? this.isPlaying,
        chapterIndex: chapterIndex ?? this.chapterIndex,
        nameOfChapter: nameOfChapter ?? this.nameOfChapter,
        nameOfBook: nameOfBook ?? this.nameOfBook);
  }

  String textOfPosition() {
    final minutes = position.inMinutes.remainder(60);
    final seconds = position.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String textOfLength() {
    final minutes = lengthOfAudio.inMinutes.remainder(60);
    final seconds = lengthOfAudio.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
