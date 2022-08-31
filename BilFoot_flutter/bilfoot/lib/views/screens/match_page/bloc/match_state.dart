part of 'match_bloc.dart';

class MatchState extends Equatable {
  const MatchState({this.upcomingMatches, this.pastMatches});

  final List<MatchModel>? upcomingMatches;
  final List<MatchModel>? pastMatches;

  @override
  List<Object?> get props => [upcomingMatches, pastMatches];
}
