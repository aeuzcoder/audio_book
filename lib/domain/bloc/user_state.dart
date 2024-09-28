/*

  USER_STATE: There is states while opening app

*/

part of 'user_bloc.dart';

sealed class UserState {}

//USER START STATE: first state for waiting
final class UserStartState extends UserState {}

//USER AUTHORIZATION STATE: used for authorization
final class UserAuthState extends UserState {}

//USER OFFLINE STATE: used if User is offline
final class UserOfflineState extends UserState {}

//USER ONLINE STATE: used if User is online
final class UserOnlineState extends UserState {}

//USER ERROR STATE: if has error
final class UserErrorState extends UserState {}

//USER LOADED STATE: if data has loaded
final class UserLoadedState extends UserState {
  final List<Book> books;

  UserLoadedState({required this.books});
}

//USER LOADING STATE: used if data of user is uploading to Firebase
final class UserLoadingState extends UserState {}
