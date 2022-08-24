part of 'team_bloc.dart';

abstract class TeamEvent extends Equatable {
  const TeamEvent();

  @override
  List<Object?> get props => [];
}

class TeamChangeCaptain extends TeamEvent {}

class TeamKickPlayer extends TeamEvent {}

class TeamQuitTeam extends TeamEvent {}

class TeamGetTeams extends TeamEvent {}

class TeamCreateTeam extends TeamEvent {}

/*
-Change captain
-Kick player
-Quit Team
-Get Teams
-Create Team





 */
