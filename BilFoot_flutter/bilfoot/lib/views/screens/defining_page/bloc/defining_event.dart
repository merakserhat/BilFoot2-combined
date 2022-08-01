part of 'defining_bloc.dart';

@immutable
abstract class DefiningEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectedPositionsChanged extends DefiningEvent {
  final List<String> positions;

  SelectedPositionsChanged({required this.positions});

  @override
  List<Object?> get props => [positions];
}

class SelectedSkillsChanged extends DefiningEvent {
  final List<String> selectedSkills;

  SelectedSkillsChanged({required this.selectedSkills});

  @override
  List<Object?> get props => [selectedSkills];
}

class DominantFeetChanged extends DefiningEvent {
  final List<String> dominantFeet;

  DominantFeetChanged({required this.dominantFeet});

  @override
  List<Object?> get props => [dominantFeet];
}
