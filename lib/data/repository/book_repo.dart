import 'package:cloud_firestore/cloud_firestore.dart';

class BookRepo {
  //GET ID BOOKS
  Future<List<String>> fetchAllBookIds(FirebaseFirestore firestore) async {
    QuerySnapshot snapshot = await firestore.collection('books').get();
    List<String> bookIds = snapshot.docs.map((doc) => doc.id).toList();
    return bookIds;
  }

  //GET DATA BOOKS

  Future<Map<String, dynamic>> fetchBookData(
      String bookId, FirebaseFirestore firestore) async {
    DocumentSnapshot doc =
        await firestore.collection('books').doc(bookId).get();
    return doc.data() as Map<String, dynamic>;
  }
}
