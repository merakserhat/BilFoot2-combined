import 'dart:async';

import 'package:bilfoot/data/models/announcements/announcement_model.dart';
import 'package:bilfoot/data/models/announcements/match_announcement_model.dart';
import 'package:bilfoot/data/models/announcements/opponent_announcement_model.dart';
import 'package:bilfoot/data/models/announcements/player_announcement_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'announcement_event.dart';
part 'announcement_state.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  AnnouncementBloc() : super(AnnouncementState()) {
    on<AnnouncementGetAnnouncements>(_announcementGetAnnouncements);
  }

  void _announcementGetAnnouncements(AnnouncementGetAnnouncements event,
      Emitter<AnnouncementState> emit) async {
    emit(state.copyWith(isLoading: true));
    Map<String, List>? announcements = await BilfootClient().getAnnouncements();

    if (announcements != null) {
      print("Bloca geldi");
      emit(
        AnnouncementState(
            playerAnnouncements: announcements["player_announcements"]
                as List<PlayerAnnouncementModel>,
            opponentAnnouncements: announcements["opponent_announcements"]
                as List<OpponentAnnouncementModel>,
            isLoading: false),
      );
    }
  }
}
