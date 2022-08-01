part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FirebaseAuthenticated extends AuthenticationEvent {
  final User user;

  FirebaseAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class FirebaseUnauthenticated extends AuthenticationEvent {}

class FirebaseEmailVerified extends AuthenticationEvent {}

class AuthenticationRegisterUser extends AuthenticationEvent {
  final List<String> dominantFeet;
  final List<String> preferredPositions;
  final List<String> specialSkills;

  AuthenticationRegisterUser({
    required this.dominantFeet,
    required this.preferredPositions,
    required this.specialSkills,
  });

  @override
  List<Object?> get props => [dominantFeet, preferredPositions, specialSkills];
}

class AuthenticationLogOut extends AuthenticationEvent {}
