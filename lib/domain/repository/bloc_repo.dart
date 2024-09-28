import 'package:audio_app/data/repository/book_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlocRepo {
  final BookRepo _bookRepo = BookRepo();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // GET ID BOOK FROM REPO
  Future<List<String>> get getBooksId => _bookRepo.fetchAllBookIds(_firestore);

  // GET DATA FROM BOOKS ID FROM REPO
  Future<List<Map<String, dynamic>>> getBooksData(List<String> booksId) async {
    final List<Map<String, dynamic>> booksData = await Future.wait(
        booksId.map((id) => _bookRepo.fetchBookData(id, _firestore)));

    return booksData;
  }
}
