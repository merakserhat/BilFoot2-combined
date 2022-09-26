part of 'team_bloc.dart';

abstract class TeamEvent extends Equatable {
  const TeamEvent();

  @override
  List<Object?> get props => [];
}

class TeamChangeCaptain extends TeamEvent {
  final String teamId;
  final String newCaptainId;

  const TeamChangeCaptain({required this.teamId, required this.newCaptainId});

  @override
  List<Object?> get props => [teamId, newCaptainId];
}

class TeamKickPlayer extends TeamEvent {
  final String teamId;
  final String kickedPlayerId;

  const TeamKickPlayer({required this.teamId, required this.kickedPlayerId});

  @override
  List<Object?> get props => [teamId, kickedPlayerId];
}

class TeamQuitTeam extends TeamEvent {
  final String teamId;

  const TeamQuitTeam({required this.teamId});

  @override
  List<Object?> get props => [teamId];
}

class TeamGetTeams extends TeamEvent {}

class TeamCreateTeam extends TeamEvent {}

/*
-Change captain
-Kick player
-Quit Team
-Get Teams
-Create Team





 */
