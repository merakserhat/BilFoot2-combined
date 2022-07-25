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
