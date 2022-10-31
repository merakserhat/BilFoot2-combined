import 'dart:convert';

import 'package:bilfoot/data/models/announcements/opponent_announcement_model.dart';
import 'package:bilfoot/data/models/announcements/player_announcement_model.dart';
import 'package:http/http.dart';

import 'client.dart';

class AnnouncementService {
  static void test() {}

  static Future<Map<String, List>?> getAnnouncements() async {
    Response? response = await BilfootClient().sendRequest(
      path: "announcement/get-announcements",
    );

    if (response == null) {
      //TODO
      print("null response get matches");
      return null;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status  get announcements");
      print(response.body);
      return null;
    }

    var jsonData = json.decode(response.body);
    print("getAnnouncements");
    print(jsonData);

    Map<String, List> returnValue = {"player_announcements": []};
    if (jsonData["player_announcements"] != null) {
      returnValue["player_announcements"] =
          (jsonData["player_announcements"] as List<dynamic>)
              .map((e) => PlayerAnnouncementModel.fromJson(e))
              .toList();
    }

    if (jsonData["opponent_announcements"] != null) {
      returnValue["opponent_announcements"] =
          (jsonData["opponent_announcements"] as List<dynamic>)
              .map((e) => OpponentAnnouncementModel.fromJson(e))
              .toList();
    }

    return returnValue;
  }

  static Future<bool> sendPlayerAnnouncementJoinRequest(
      String announcementId) async {
    Response? response = await BilfootClient().sendRequest(
      path: "announcement/player-announcement-join-request",
      body: {
        "announcement_id": announcementId,
      },
      method: Method.post,
    );

    if (response == null) {
      //TODO
      print("null response get matches");
      return false;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status  get announcements");
      print(response.body);
      return false;
    }

    return true;
  }
}
