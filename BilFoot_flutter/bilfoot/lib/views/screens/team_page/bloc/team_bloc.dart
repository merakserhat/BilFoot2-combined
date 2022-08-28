import 'dart:async';

import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'team_event.dart';
part 'team_state.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  TeamBloc() : super(const TeamState()) {
    on<TeamChangeCaptain>(_teamChangeCaptain);
    on<TeamKickPlayer>(_teamKickPlayer);
    on<TeamQuitTeam>(_teamQuitTeam);
    on<TeamGetTeams>(_teamGetTeams);
    on<TeamCreateTeam>(_teamCreateTeam);
  }

  _teamChangeCaptain(TeamChangeCaptain event, Emitter<TeamState> emit) {
    TeamModel? changedTeam;

    for (TeamModel team in state.teams!) {
      if (team.id == event.teamId) {
        changedTeam = team;
      }
    }

    if (changedTeam == null) return;

    List<TeamModel> teams = state.teams ?? [];

    teams.removeWhere((element) => element.id == event.teamId);

    changedTeam = changedTeam.copyWith(captain: event.newCaptainId);

    emit(state.copWith(teams: [changedTeam, ...teams]));
  }

  _teamKickPlayer(TeamKickPlayer event, Emitter<TeamState> emit) {
    TeamModel? changedTeam;

    for (TeamModel team in state.teams!) {
      if (team.id == event.teamId) {
        changedTeam = team;
      }
    }

    if (changedTeam == null) return;

    List<TeamModel> teams = state.teams ?? [];

    teams.removeWhere((element) => element.id == event.teamId);

    List<PlayerModel> players = changedTeam.players;

    players.removeWhere((element) => element.id == event.kickedPlayerId);

    changedTeam = changedTeam.copyWith(players: [...players]);

    emit(state.copWith(teams: [changedTeam, ...teams]));
  }

  _teamQuitTeam(TeamQuitTeam event, Emitter<TeamState> emit) {
    Program.program.user!.teams.remove(event.teamId);

    List<TeamModel> teams = state.teams ?? [];

    teams.removeWhere((element) => element.id == event.teamId);

    emit(state.copWith(
        teams: teams, teamCount: Program.program.user!.teams.length));
  }

  _teamGetTeams(TeamGetTeams event, Emitter<TeamState> emit) async {
    if (Program.program.user != null) {
      List<TeamModel> teams = await BilfootClient()
          .getTeamsWithIds(ids: Program.program.user!.teams);

      emit(state.copWith(teams: teams));
    }
  }

  _teamCreateTeam(TeamCreateTeam event, Emitter<TeamState> emit) async {
    if (Program.program.user != null) {
      List<TeamModel> teams = await BilfootClient()
          .getTeamsWithIds(ids: Program.program.user!.teams);

      emit(state.copWith(teams: teams, teamCount: teams.length));
    }
  }
}
