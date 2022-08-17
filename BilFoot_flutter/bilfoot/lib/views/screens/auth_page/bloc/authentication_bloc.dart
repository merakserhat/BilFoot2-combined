import 'dart:async';

import 'package:bilfoot/config/utils/auth_service.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUninitialized()) {
    initFirebaseAuth();

    on<FirebaseAuthenticated>(_authenticationAuthenticated);
    on<FirebaseUnauthenticated>(_authenticationUnauthenticated);
    on<FirebaseEmailVerified>(_authenticationEmailVerified);
    on<AuthenticationRegisterUser>(_authenticationRegisterUser);
    on<AuthenticationLogOut>(_authenticationLogOut);
  }

  _authenticationAuthenticated(
      FirebaseAuthenticated event, Emitter<AuthenticationState> emit) async {
    if (event.user.emailVerified) {
      emit(AuthenticationAuthenticated(
          user: event.user, emailVerified: true, homeDataLoading: true));

      PlayerModel? playerModel = await BilfootClient().getHomeData();

      emit((state as AuthenticationAuthenticated)
          .copyWith(playerModel: playerModel, homeDataLoading: false));
    } else {
      emit(AuthenticationAuthenticated(
          user: event.user, emailVerified: false, homeDataLoading: false));
    }
  }

  _authenticationUnauthenticated(
      FirebaseUnauthenticated event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationUnauthenticated());
  }

  void initFirebaseAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      print(user);
      if (user == null) {
        add(FirebaseUnauthenticated());
      } else {
        await AuthService.service.getIdToken(user);
        add(FirebaseAuthenticated(user: user));
      }
    });

    FirebaseAuth.instance.idTokenChanges().listen((User? user) async {
      if (user == null) {
        add(FirebaseUnauthenticated());
      } else {
        await AuthService.service.getIdToken(user);
        add(FirebaseAuthenticated(user: user));
      }
    });
  }

  _authenticationEmailVerified(FirebaseEmailVerified event, emit) async {
    if (state is AuthenticationAuthenticated) {
      print("buraya geldi");
      emit((state as AuthenticationAuthenticated).copyWith(
          emailVerified: true, homeDataLoading: true, playerModel: null));

      print((state as AuthenticationAuthenticated).playerModel);

      PlayerModel? playerModel = await BilfootClient().getHomeData();

      emit((state as AuthenticationAuthenticated).copyWith(
          homeDataLoading: false,
          playerModel: playerModel,
          emailVerified: true));
    }
  }

  _authenticationRegisterUser(AuthenticationRegisterUser event,
      Emitter<AuthenticationState> emit) async {
    if (state is AuthenticationAuthenticated) {
      User user = (state as AuthenticationAuthenticated).user;
      bool success = await BilfootClient().registerUser(
        specialSkills: event.specialSkills,
        dominantFeet: event.dominantFeet,
        preferredPositions: event.preferredPositions,
        firebaseId: user.uid,
        email: user.email!,
      );

      if (!success) {
        print("Some error occured while _authenticationRegisterUser");
      }

      PlayerModel? playerModel = await BilfootClient().getHomeData();

      if (playerModel == null) {
        print(
            "Some error occured while _authenticationRegisterUser getHomeData");
      }

      emit((state as AuthenticationAuthenticated)
          .copyWith(homeDataLoading: false, playerModel: playerModel));
    }
  }

  _authenticationLogOut(
      AuthenticationLogOut event, Emitter<AuthenticationState> emit) {
    print("sas");
    AuthService.service.logout();
    emit(AuthenticationUnauthenticated());
  }
}
