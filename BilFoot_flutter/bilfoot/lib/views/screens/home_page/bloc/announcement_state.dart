part of 'announcement_bloc.dart';

class AnnouncementState extends Equatable {
  const AnnouncementState(
      {this.playerAnnouncements,
      this.opponentAnnouncements,
      this.isLoading = false});

  final List<PlayerAnnouncementModel>? playerAnnouncements;
  final List<OpponentAnnouncementModel>? opponentAnnouncements;

  final bool isLoading;

  AnnouncementState copyWith({
    List<PlayerAnnouncementModel>? playerAnnouncements,
    List<OpponentAnnouncementModel>? opponentAnnouncements,
    isLoading,
  }) =>
      AnnouncementState(
          playerAnnouncements: playerAnnouncements ?? this.playerAnnouncements,
          opponentAnnouncements:
              opponentAnnouncements ?? this.opponentAnnouncements,
          isLoading: isLoading ?? this.isLoading);

  @override
  List<Object?> get props =>
      [playerAnnouncements, opponentAnnouncements, isLoading];
}
