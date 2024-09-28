import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserStartState()) {
    on<UserAuthEvent>(
      (event, emit) async {
        final user = FirebaseAuth.instance.currentUser;
        final connectivity = await (Connectivity().checkConnectivity());

        //Checking user for authorization
        if (user != null) {
          //User authorizated

          //Checking device connectivity
          if (connectivity.contains(ConnectivityResult.none)) {
            //User is offline
            emit(UserOfflineState());
          } else {
            //User is online
            emit(UserOnlineState());
          }
        } else {
          //User didn`t authorizate
          emit(UserAuthState());
        }
      },
    );
  }
}
