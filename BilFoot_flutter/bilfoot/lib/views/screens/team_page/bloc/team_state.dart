part of 'team_bloc.dart';

class TeamState extends Equatable {
  final List<TeamModel>? teams;

  const TeamState({this.teams});

  TeamState copWith({List<TeamModel>? teams}) =>
      TeamState(teams: teams ?? this.teams);

  @override
  List<Object?> get props => [teams];
}
