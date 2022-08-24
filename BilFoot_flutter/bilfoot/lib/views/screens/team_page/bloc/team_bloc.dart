import 'dart:async';

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
    /*List<TeamModel> teams = state.teams!;
    TeamModel patates = teams[0];
    patates.players.add(Program.program.memduh);
    emit(state.copWith(teams: [
      patates.copyWith(players: [...patates.players, Program.program.ali])
    ]));*/
  }

  _teamKickPlayer(TeamKickPlayer event, Emitter<TeamState> emit) {}

  _teamQuitTeam(TeamQuitTeam event, Emitter<TeamState> emit) {}

  _teamGetTeams(TeamGetTeams event, Emitter<TeamState> emit) async {
    if (Program.program.user != null) {
      List<TeamModel> teams = await BilfootClient()
          .getTeamsWithIds(ids: Program.program.user!.teams);

      emit(state.copWith(teams: teams));
    }
  }

  _teamCreateTeam(TeamCreateTeam event, Emitter<TeamState> emit) {}
}
