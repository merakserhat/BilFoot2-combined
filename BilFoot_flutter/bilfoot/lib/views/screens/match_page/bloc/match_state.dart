part of 'match_bloc.dart';

class MatchState extends Equatable {
  const MatchState(
      {this.upcomingMatches, this.pastMatches, this.isLoading = false});

  final List<MatchModel>? upcomingMatches;
  final List<MatchModel>? pastMatches;
  final bool isLoading;

  MatchState copyWith({
    List<MatchModel>? upcomingMatches,
    List<MatchModel>? pastMatches,
    isLoading,
  }) =>
      MatchState(
        upcomingMatches: upcomingMatches ?? this.upcomingMatches,
        pastMatches: pastMatches ?? this.pastMatches,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [upcomingMatches, pastMatches, isLoading];
}
