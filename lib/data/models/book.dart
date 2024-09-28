class Book {
  final String title;
  final String tutorial;
  final List<String> chapters;
  final String image;

  Book({
    required this.title,
    required this.tutorial,
    required this.chapters,
    required this.image,
  });
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
        title: map['title'],
        tutorial: map['tutorial'],
        chapters: List<String>.from(map['chapters']),
        image: map['image']);
  }
}
