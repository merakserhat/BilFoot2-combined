import 'package:bilfoot/data/models/team_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
      TeamEditSaveButtonClicked event, Emitter<TeamEditState> emit) {
    //TODO: Burada edit
  }
}
