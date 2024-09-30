import 'dart:developer';

import 'package:audio_app/data/models/book.dart';
import 'package:audio_app/domain/repository/bloc_repo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  // Initialize the repository for fetching data
  final BlocRepo _blocRepo = BlocRepo();

  // BLoC constructor: Register event handlers for user authentication
  UserBloc() : super(UserStartState()) {
    // Handle event when user is authenticated
    on<UserAuthenticatedEvent>(_onUserAuthenticated);

    // Handle event for checking user authentication and internet connectivity
    on<UserAuthEvent>(_onUserAuth);
  }

  // Event handler for when the user is already authenticated
  Future<void> _onUserAuthenticated(
      UserAuthenticatedEvent event, Emitter<UserState> emit) async {
    try {
      // Emit loading state while data is being fetched
      emit(UserLoadingState());

      // Fetch book data from the repository
      List<Book> books = await _fetchBooks();

      // Emit loaded state with the fetched books
      emit(UserLoadedState(books: books));
    } catch (e) {
      // Emit error state if something goes wrong and log the error
      emit(UserErrorState());
      log('ERROR: $e');
    }
  }

  // Event handler for checking user authentication and internet connection
  Future<void> _onUserAuth(UserAuthEvent event, Emitter<UserState> emit) async {
    // Check the current internet connectivity status
    final connectivity = await Connectivity().checkConnectivity();

    // If there is no internet connection, emit the offline state
    if (connectivity.contains(ConnectivityResult.none)) {
      emit(UserOfflineState());
      return; // Stop further execution if offline
    }

    // If internet is available, emit online state
    emit(UserOnlineState());

    // Check if the user is authenticated with Firebase
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is authenticated, fetch their data
      try {
        // Emit loading state while fetching data
        emit(UserLoadingState());

        // Fetch books data from the repository
        List<Book> books = await _fetchBooks();

        // Get url

        // Emit loaded state with the fetched books
        emit(UserLoadedState(books: books));
      } catch (e) {
        // Emit error state if something goes wrong and log the error
        emit(UserErrorState());
        log('ERROR: $e');
      }
    } else {
      // If user is not authenticated, emit the authentication state
      emit(UserAuthState());
    }
  }

  // Helper method to fetch book data from the repository
  Future<List<Book>> _fetchBooks() async {
    // Get a list of book IDs from the repository
    List<String> booksId = await _blocRepo.getBooksId;

    // Fetch the data for each book using the list of IDs
    List<Map<String, dynamic>> booksData =
        await _blocRepo.getBooksData(booksId);

    //changing url of all private url to public
    for (var book in booksData) {
      book['image'] = await getPublicUrl(book['image']);
      //log('IMAGE' '  ${book['image']}');

      book['tutorial'] = await getPublicUrl(book['tutorial']);
      //log('TUTORIAL' '  ${book['tutorial']}');

      List<dynamic> chapters = List<dynamic>.from(book['chapters']);
      book['chapters'] =
          await Future.wait(chapters.map((chapter) => getPublicUrl(chapter)));
    }
    // Map the fetched data to the Book model and return the list
    return booksData.map((book) => Book.fromMap(book)).toList();
  }

  //Changing private url to public
  Future<String> getPublicUrl(String gsUrl) async {
    try {
      // create public url to firebase
      final ref = FirebaseStorage.instance.refFromURL(gsUrl);
      String publicUrl = await ref.getDownloadURL();

      return publicUrl;
    } catch (e) {
      // If data is not url
      log('Error fetching public URL: $e');
      return '';
    }
  }
}
