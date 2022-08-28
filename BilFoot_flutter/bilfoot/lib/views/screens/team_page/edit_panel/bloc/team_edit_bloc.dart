import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bilfoot/views/screens/team_page/bloc/team_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'team_edit_event.dart';
part 'team_edit_state.dart';

class TeamEditBloc extends Bloc<TeamEditEvent, TeamEditState> {
  TeamEditBloc() : super(const TeamEditState()) {
    on<TeamEditEvent>((event, emit) {});

    on<TeamEditInitializeExistingTeam>(_teamEditInitializeExistingTeam);
    on<TeamEditNameChanged>(_teamEditNameChanged);
    on<TeamEditShortNameChanged>(_teamEditShortNameChanged);
    on<TeamEditMainColorChanged>(_teamEditMainColorChanged);
    on<TeamEditAccentColorChanged>(_teamEditAccentColorChanged);
    on<TeamEditSaveButtonClicked>(_teamEditSaveButtonClicked);
  }

  _teamEditInitializeExistingTeam(
      TeamEditInitializeExistingTeam event, Emitter<TeamEditState> emit) {
    emit(
      state.copyWith(
        isEditing: true,
        name: event.teamModel.name,
        shortName: event.teamModel.shortName,
        mainColor: event.teamModel.mainColor,
        accentColor: event.teamModel.accentColor,
        teamId: event.teamModel.id,
      ),
    );
  }

  _teamEditNameChanged(TeamEditNameChanged event, Emitter<TeamEditState> emit) {
    emit(state.copyWith(name: event.name));
  }

  _teamEditShortNameChanged(
      TeamEditShortNameChanged event, Emitter<TeamEditState> emit) {
    emit(state.copyWith(shortName: event.shortName));
  }

  _teamEditMainColorChanged(
      TeamEditMainColorChanged event, Emitter<TeamEditState> emit) {
    emit(state.copyWith(mainColor: event.mainColor));
  }

  _teamEditAccentColorChanged(
      TeamEditAccentColorChanged event, Emitter<TeamEditState> emit) {
    emit(state.copyWith(accentColor: event.accentColor));
  }

  _teamEditSaveButtonClicked(
      TeamEditSaveButtonClicked event, Emitter<TeamEditState> emit) async {
    emit(state.copyWith(isLoading: true));

    if (state.isEditing && state.teamId != null) {
      bool isSuccess = await BilfootClient().editTeam(
        shortName: state.shortName,
        teamName: state.name,
        mainColor: state.mainColor,
        accentColor: state.accentColor,
        teamId: state.teamId!,
      );

      if (isSuccess) {
        event.teamBloc.add(TeamCreateTeam());
        event.onFinished();
      }
    } else {
      bool isSuccess = await BilfootClient().createTeam(
          shortName: state.shortName,
          teamName: state.name,
          mainColor: state.mainColor,
          accentColor: state.accentColor);

      if (isSuccess) {
        event.teamBloc.add(TeamCreateTeam());
        event.onFinished();
      }
    }

    emit(state.copyWith(isLoading: false));
  }
}
