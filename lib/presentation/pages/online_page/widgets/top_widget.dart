import 'package:audio_app/core/theme/colors.dart';
import 'package:audio_app/data/models/book.dart';
import 'package:flutter/material.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({super.key, required this.books});
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //NEW REALESES BOOKS
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New Realeses book',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'See All',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: widgetColor),
              ),
            ],
          ),
        ),
        //LIST VIEW BUILDER
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 178,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: books.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final book = books[index];

                //CONTAINER IMAGE
                return Container(
                  height: 172,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: widgetColor.withOpacity(0.3),
                            offset: const Offset(3, 1),
                            blurRadius: 2,
                            blurStyle: BlurStyle.normal)
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      book.image,
                      fit: BoxFit
                          .cover, // Устанавливает, как изображение будет масштабироваться
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: widgetColor,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
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
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
