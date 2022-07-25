part of 'defining_bloc.dart';

class DefiningState extends Equatable {
  final List<String> selectedSkills;
  final List<String> dominantFeet;
  final List<String> positions;

  const DefiningState(
      {this.selectedSkills = const [],
      this.positions = const [],
      this.dominantFeet = const ["Right"]});

  DefiningState copyWith({
    List<String>? selectedSkills,
    List<String>? dominantFeet,
    List<String>? positions,
  }) =>
      DefiningState(
          selectedSkills: selectedSkills ?? this.selectedSkills,
          dominantFeet: dominantFeet ?? this.dominantFeet,
          positions: positions ?? this.positions);

  @override
  List<Object?> get props => [selectedSkills, dominantFeet, positions];
}
