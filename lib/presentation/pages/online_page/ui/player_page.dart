import 'package:audio_app/core/theme/colors.dart';
import 'package:audio_app/core/widgets/custom_app_bar.dart';
import 'package:audio_app/data/models/book.dart';
import 'package:audio_app/presentation/pages/online_page/data/cubit/audio_player_cubit.dart';
import 'package:audio_app/presentation/pages/online_page/data/cubit/audio_player_state.dart';
import 'package:audio_app/presentation/pages/online_page/widgets/backgorund_widget.dart';
import 'package:audio_app/presentation/pages/online_page/widgets/chapter_tile_widget.dart';
import 'package:audio_app/presentation/pages/online_page/widgets/player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage(
      {super.key,
      required this.book,
      required this.bookIndex,
      required this.checkingBook});
  final Book book;
  final int bookIndex;
  final bool checkingBook;

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  void initState() {
    if (!widget.checkingBook) {
      context.read<AudioPlayerCubit>().initializePlayer(
          isPlay: false,
          url: widget.book.chapters[0],
          chapterIndex: 0,
          bookIndex: widget.bookIndex,
          nameOfChapter: 'Kirish',
          nameOfBook: widget.book.title);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AudioPlayerCubit>();

    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Now playing',
          colorTitle: Colors.white,
          colorBg: Colors.transparent,
          colorFg: fontColor,
        ),
        body: Stack(children: [
          //BACKGROUND
          const BackgorundWidget(),

          //FOREGROUND

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
                    //IMAGE
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        width: size.height / 4.1,
                        height: size.height / 3.2,
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
                            widget.book.image,
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

                    //TEXTS UNDER THE IMAGE
                    BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
                      builder: (context, state) {
                        if (state is AudioPlayerLoadingState) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.book.title,
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      widget.book.author,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              PlayerWidget(
                                state: state,
                                book: widget.book,
                              ),
                              SizedBox(
                                width: size.width,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: widget.book.chapters.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final chapter = widget.book.chapters[index];
                                    return ChapterTileWidget(
                                      isPlaying: state.isPlaying &&
                                          index == state.chapterIndex,
                                      indexChapter: index,
                                      title: widget.book.title,
                                      endOfChapter: widget.book.chapters.length,
                                      onTap: () {
                                        String nameOfChapter;
                                        if (index == 0) {
                                          nameOfChapter = 'Kitob haqida';
                                        } else if (index == 1) {
                                          nameOfChapter = 'Kirish';
                                        } else if (index ==
                                            widget.book.chapters.length - 1) {
                                          nameOfChapter = 'Xulosa';
                                        } else {
                                          nameOfChapter =
                                              '${index - 1} - Mavzu';
                                        }

                                        bloc.initializePlayer(
                                          isPlay: true,
                                          url: chapter,
                                          chapterIndex: index,
                                          bookIndex: bloc.bookIndex,
                                          nameOfChapter: nameOfChapter,
                                          nameOfBook: widget.book.title,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}
