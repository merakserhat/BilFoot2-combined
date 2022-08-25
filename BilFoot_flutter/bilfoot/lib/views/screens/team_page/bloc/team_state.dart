part of 'team_bloc.dart';

class TeamState extends Equatable {
  final List<TeamModel>? teams;
  final int teamCount;

  const TeamState({this.teams, this.teamCount = 0});

  TeamState copWith({List<TeamModel>? teams, int? teamCount}) => TeamState(
      teams: teams ?? this.teams, teamCount: teamCount ?? this.teamCount);

  @override
  List<Object?> get props => [teams, teamCount];
}
