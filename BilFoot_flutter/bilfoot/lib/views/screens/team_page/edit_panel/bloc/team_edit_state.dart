part of 'team_edit_bloc.dart';

class TeamEditState extends Equatable {
  const TeamEditState({
    this.name = "",
    this.shortName = "",
    this.mainColor = "ff0000",
    this.accentColor = "ffffff",
    this.isEditing = false,
  });

  final bool isEditing;
  final String name;
  final String shortName;
  final String mainColor;
  final String accentColor;

  TeamEditState copyWith({
    String? name,
    String? shortName,
    String? mainColor,
    String? accentColor,
    bool? isEditing,
  }) =>
      TeamEditState(
        name: name ?? this.name,
        shortName: shortName ?? this.shortName,
        mainColor: mainColor ?? this.mainColor,
        accentColor: accentColor ?? this.accentColor,
        isEditing: isEditing ?? this.isEditing,
      );

  @override
  List<Object> get props =>
      [name, shortName, mainColor, accentColor, isEditing];
}
