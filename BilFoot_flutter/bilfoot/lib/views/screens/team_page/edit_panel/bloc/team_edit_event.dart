part of 'team_edit_bloc.dart';

abstract class TeamEditEvent extends Equatable {
  const TeamEditEvent();

  @override
  List<Object?> get props => [];
}

class TeamEditInitializeExistingTeam extends TeamEditEvent {
  final TeamModel teamModel;

  const TeamEditInitializeExistingTeam(this.teamModel);

  @override
  List<Object?> get props => [teamModel];
}

class TeamEditNameChanged extends TeamEditEvent {
  final String name;

  const TeamEditNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class TeamEditShortNameChanged extends TeamEditEvent {
  final String shortName;

  const TeamEditShortNameChanged(this.shortName);

  @override
  List<Object?> get props => [shortName];
}

class TeamEditMainColorChanged extends TeamEditEvent {
  final String mainColor;

  const TeamEditMainColorChanged(this.mainColor);

  @override
  List<Object?> get props => [mainColor];
}

class TeamEditAccentColorChanged extends TeamEditEvent {
  final String accentColor;

  const TeamEditAccentColorChanged(this.accentColor);

  @override
  List<Object?> get props => [accentColor];
}

class TeamEditSaveButtonClicked extends TeamEditEvent {
  final TeamBloc teamBloc;
  final VoidCallback onFinished;

  const TeamEditSaveButtonClicked(this.teamBloc, this.onFinished);
}
