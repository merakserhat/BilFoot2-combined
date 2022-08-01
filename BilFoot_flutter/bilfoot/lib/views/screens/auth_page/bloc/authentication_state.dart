part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {}

class AuthenticationUninitialized extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationAuthenticated extends AuthenticationState {
  final User user;
  final bool emailVerified;
  final bool homeDataLoading;
  final PlayerModel? playerModel;

  AuthenticationAuthenticated({
    required this.user,
    required this.emailVerified,
    this.playerModel,
    this.homeDataLoading = true,
  });

  AuthenticationAuthenticated copyWith({
    User? user,
    bool? emailVerified,
    bool? homeDataLoading,
    PlayerModel? playerModel,
  }) =>
      AuthenticationAuthenticated(
        user: user ?? this.user,
        emailVerified: emailVerified ?? this.emailVerified,
        playerModel: playerModel ?? this.playerModel,
        homeDataLoading: homeDataLoading ?? this.homeDataLoading,
      );

  @override
  List<Object?> get props =>
      [user, playerModel, homeDataLoading, emailVerified];
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
