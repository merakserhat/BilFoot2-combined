part of 'team_edit_bloc.dart';

class TeamEditState extends Equatable {
  const TeamEditState({
    this.name = "",
    this.shortName = "",
    this.mainColor = "ff0000",
    this.accentColor = "ffffff",
    this.isEditing = false,
    this.isLoading = false,
    this.teamId,
  });

  final bool isLoading;
  final bool isEditing;
  final String name;
  final String shortName;
  final String mainColor;
  final String accentColor;
  final String? teamId;

  TeamEditState copyWith({
    String? name,
    String? shortName,
    String? mainColor,
    String? accentColor,
    bool? isEditing,
    bool? isLoading,
    String? teamId,
  }) =>
      TeamEditState(
        name: name ?? this.name,
        shortName: shortName ?? this.shortName,
        mainColor: mainColor ?? this.mainColor,
        accentColor: accentColor ?? this.accentColor,
        isEditing: isEditing ?? this.isEditing,
        isLoading: isLoading ?? this.isLoading,
        teamId: teamId ?? this.teamId,
      );

  @override
  List<Object?> get props =>
      [name, shortName, mainColor, accentColor, isEditing, isLoading, teamId];
}
