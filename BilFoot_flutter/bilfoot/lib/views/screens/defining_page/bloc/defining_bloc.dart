import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'defining_event.dart';
part 'defining_state.dart';

class DefiningBloc extends Bloc<DefiningEvent, DefiningState> {
  DefiningBloc() : super(const DefiningState()) {
    on<SelectedPositionsChanged>(_selectedPositionsChanged);
    on<SelectedSkillsChanged>(_selectedSkillsChanged);
    on<DominantFeetChanged>(_dominantFeetChanged);
  }

  _selectedPositionsChanged(
      SelectedPositionsChanged event, Emitter<DefiningState> emit) {
    emit(state.copyWith(positions: event.positions));
  }

  _selectedSkillsChanged(
      SelectedSkillsChanged event, Emitter<DefiningState> emit) {
    emit(state.copyWith(selectedSkills: event.selectedSkills));
  }

  _dominantFeetChanged(DominantFeetChanged event, Emitter<DefiningState> emit) {
    emit(state.copyWith(dominantFeet: event.dominantFeet));
  }
}
