/*

  USER EVENT: Event when user opens the app

*/

part of 'user_bloc.dart';

sealed class UserEvent {}

//Called always when the app is opened
final class UserAuthEvent extends UserEvent {}
