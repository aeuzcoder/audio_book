import 'dart:developer';

import 'package:audio_app/data/models/book.dart';
import 'package:audio_app/domain/repository/bloc_repo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserStartState()) {
    on<UserAuthEvent>(
      (event, emit) async {
        final BlocRepo blocRepo = BlocRepo();
        final connectivity = await (Connectivity().checkConnectivity());

        //CHECK THE INTERNET CONNECTION
        if (connectivity.contains(ConnectivityResult.none)) {
          //USER IS OFFLINE
          emit(UserOfflineState());
        } else {
          //USER ONLINE
          emit(UserOnlineState());

          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            //USER AUTHENTIFICATED
            try {
              //LOADING DATA
              emit(UserLoadingState());

              //get books id from database for fetching all books data
              List<String> booksId = await blocRepo.getBooksId;

              //fetch all books data like json
              List<Map<String, dynamic>> booksData =
                  await blocRepo.getBooksData(booksId);

              //fetch all books data like class Book
              List<Book> books =
                  booksData.map((book) => Book.fromMap(book)).toList();

              //LOADED ALL DATA FROM DATABASE
              emit(UserLoadedState(books: books));
            } catch (e) {
              //ERROR WHEN LOADING DATA FROM DATABASE
              emit(UserErrorState());
              log('ERROR: $e');
            }
          } else {
            //USER DIDN'T AUTHENTIFICATE
            emit(UserAuthState());
          }
        }
      },
    );
  }
}
