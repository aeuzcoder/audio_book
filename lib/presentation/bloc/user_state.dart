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

//USER LOADING STATE: used if data of user is uploading to Firebase
final class UserLoadingState extends UserState {}
