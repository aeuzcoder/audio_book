import 'package:audio_app/core/theme/colors.dart';
import 'package:audio_app/core/widgets/custom_app_bar.dart';
import 'package:audio_app/data/models/book.dart';
import 'package:audio_app/presentation/pages/online_page/widgets/backgorund_widget.dart';
import 'package:audio_app/presentation/pages/online_page/widgets/chapter_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key, required this.books});
  final List<Book> books;

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  bool loadFirstChapter = true;
  bool chapterTapped = false;

  final player = AudioPlayer();
  bool isMounted = true; // Флаг для контроля состояния
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  int chapterIndex = 0; // Индекс текущей главы
  late Book book;
  int? playingChapterIndex; // Индекс текущей проигрываемой главы

  @override
  void initState() {
    super.initState();
    book = widget.books.first;
    isMounted = true; // Инициализация флага
  }

  @override
  void dispose() {
    isMounted = false;
    player.dispose();
    super.dispose();
  }

  void playMusic(String url, int index) async {
    await player.setUrl(url);
    player.play();
    setState(() {
      playingChapterIndex =
          index; // Устанавливаем текущую главу как проигрываемую
    });

    player.positionStream.listen((p) {
      if (isMounted) {
        setState(() {
          position = p;
        });
      }
    });

    player.durationStream.listen((d) {
      if (d != null && isMounted) {
        setState(() {
          duration = d;
        });
      }
    });

    player.playerStateStream.listen((state) {
      if (player.processingState == ProcessingState.completed) {
        if (isMounted) {
          setState(() {
            position = Duration.zero;
          });
        }
        player.pause();
        player.seek(position);
      }
    });
  }

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void handlePlayPause() {
    if (player.playing) {
      player.pause();
      setState(() {
        playingChapterIndex = null; // Сбрасываем проигрываемую главу
      });
    } else {
      playMusic(book.chapters[chapterIndex], chapterIndex);
    }
  }

  void handleSeek(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Now playing',
        colorTitle: Colors.white,
        colorBg: Colors.transparent,
        colorFg: fontColor,
      ),
      body: Stack(
        children: [
          const BackgorundWidget(),
          SizedBox(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: chapterTapped ? 0 : size.height / 4.1,
                        height: chapterTapped ? 0 : size.height / 3.2,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: fontColor.withOpacity(0.3),
                              offset: const Offset(2, 2),
                              blurRadius: 3,
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.books.first.image,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: widgetColor,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return const Center(child: Text('Error'));
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Kirish',
                            style: TextStyle(
                              color: widgetColor,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            book.title,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            book.author,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(formatDuration(position)),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 2.0,
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 8.0),
                                    overlayShape: const RoundSliderOverlayShape(
                                        overlayRadius: 20.0),
                                  ),
                                  child: SizedBox(
                                    width: size.width / 1.8,
                                    child: Slider(
                                      thumbColor: widgetColor,
                                      activeColor: widgetColor,
                                      min: 0.0,
                                      max: duration.inSeconds.toDouble(),
                                      value: position.inSeconds.toDouble(),
                                      onChanged: handleSeek,
                                    ),
                                  ),
                                ),
                                Text(formatDuration(duration)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (chapterIndex > 0) {
                                      chapterIndex = chapterIndex - 1;
                                      playMusic(book.chapters[chapterIndex],
                                          chapterIndex);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.skip_previous_rounded,
                                    size: 36,
                                    color: fontColor.withOpacity(0.7),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: handlePlayPause,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: const BoxDecoration(
                                        color: widgetColor,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      player.playing
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 32,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (chapterIndex <
                                        book.chapters.length - 1) {
                                      chapterIndex = chapterIndex + 1;
                                      playMusic(book.chapters[chapterIndex],
                                          chapterIndex);
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
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: book.chapters.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final chapter = book.chapters[index];
                          return ChapterTileWidget(
                            indexChapter: index,
                            title: book.title,
                            endOfChapter: book.chapters.length,
                            isPlaying: playingChapterIndex ==
                                index, // Проверяем, проигрывается ли
                            onTap: () {
                              playMusic(chapter, index);
                              chapterIndex = index;
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
