class Book {
  final String title;
  final List<String> chapters;
  final String image;
  final String author;

  Book({
    required this.title,
    required this.chapters,
    required this.image,
    required this.author,
  });
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
        title: map['title'],
        author: map['author'],
        chapters: List<String>.from(map['chapters']),
        image: map['image']);
  }
}
