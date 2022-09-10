import 'dart:convert';

import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:http/http.dart';

class MatchService {
  static void test() {}

  static Future<Map<String, List<MatchModel>>?> getMatches() async {
    Response? response = await BilfootClient().sendRequest(
      path: "match/get-matches",
    );

    if (response == null) {
      //TODO
      print("null response get matches");
      return null;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status  get matchesl");
      print(response.body);
      return null;
    }

    var jsonData = json.decode(response.body);
    print("getmatches");
    print(jsonData);
    if (jsonData["upcoming_matches"] != null &&
        jsonData["past_matches"] != null) {
      return {
        "upcoming_matches": (jsonData["upcoming_matches"] as List<dynamic>)
            .map((e) => MatchModel.fromJson(e))
            .toList(),
        "past_matches": (jsonData["past_matches"] as List<dynamic>)
            .map((e) => MatchModel.fromJson(e))
            .toList(),
      };
    }

    return null;
  }

  static Future<bool> quitMatch({required String matchId}) async {
    Response? response = await BilfootClient().sendRequest(
      path: "match/quit-match",
      body: {
        "match_id": matchId,
      },
      method: Method.post,
    );

    if (response == null) {
      //TODO
      print("null response quit match");
      return false;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status quit match");
      print(response.body);
      return false;
    }

    print(response.body);
    return true;
  }

  static Future<bool> kickPlayer(
      {required String matchId, required String kickedPlayerId}) async {
    Response? response = await BilfootClient().sendRequest(
      path: "match/kick-player",
      body: {
        "match_id": matchId,
        "kicked_player_id": kickedPlayerId,
      },
      method: Method.post,
    );

    if (response == null) {
      //TODO
      print("null response kick player");
      return false;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status kick player");
      print(response.body);
      return false;
    }

    print(response.body);
    return true;
  }

  static Future<bool> giveAuth(
      {required String matchId, required String newAuthId}) async {
    Response? response = await BilfootClient().sendRequest(
      path: "match/give-auth",
      body: {
        "match_id": matchId,
        "auth_player_id": newAuthId,
      },
      method: Method.post,
    );

    if (response == null) {
      //TODO
      print("null response give auth");
      return false;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status  give auth");
      print(response.body);
      return false;
    }

    print(response.body);
    return true;
  }

  static Future<bool> getMatchInvitation({
    required String fromId,
    required String toId,
    required String matchId,
  }) async {
    Response? response = await BilfootClient().sendRequest(
      path:
          "match/get-match-invitation?from_id=$fromId&to_id=$toId&match_id=$matchId",
    );

    if (response == null) {
      //TODO
      print("null response get match invitation");
      return false;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status get match invitation");
      print(response.body);
      return false;
    }

    var jsonData = json.decode(response.body);
    print("get match invitation");
    print(jsonData);
    if (jsonData["invitation"] != null) {
      return true;
    }

    return false;
  }

  static Future<bool> inviteToMatch({
    required String matchId,
    required String toId,
  }) async {
    Response? response = await BilfootClient().sendRequest(
      path: "match/invite-to-match",
      body: {
        "match_id": matchId,
        "to_id": toId,
      },
      method: Method.post,
    );

    if (response == null) {
      //TODO
      print("null response inviteToMatch");
      return false;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status inviteToMatch");
      print(response.body);
      return false;
    }

    print(response.body);
    return true;
  }

//  const { date, hour, pitch, is_pitch_approved, show_on_table, people_limit } =
  static Future<MatchModel?> createMatch({
    required DateTime date,
    required String hour,
    required String pitch,
    required bool isPitchApproved,
    required bool showOnTable,
    required int peopleLimit,
  }) async {
    Response? response = await BilfootClient().sendRequest(
      path: "match/create-match",
      body: {
        "date": date.toIso8601String(),
        "hour": hour,
        "pitch": pitch,
        "is_pitch_approved": isPitchApproved,
        "show_on_table": showOnTable,
        "people_limit": peopleLimit,
      },
      method: Method.post,
    );

    if (response == null) {
      //TODO
      print("null response createTeam");
      return null;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status createTeam");
      print(response.body);
      return null;
    }

    var jsonData = json.decode(response.body);
    print("createTeam");
    print(jsonData);
    if (jsonData["match"] != null) {
      return MatchModel.fromJson(jsonData["match"]);
    }

    return null;
  }

  //  const { date, hour, pitch, is_pitch_approved, show_on_table, people_limit } =
  static Future<MatchModel?> editMatch({
    required String id,
    required DateTime date,
    required String hour,
    required String pitch,
    required bool isPitchApproved,
    required bool showOnTable,
    required int peopleLimit,
  }) async {
    Response? response = await BilfootClient().sendRequest(
      path: "match/edit-match",
      body: {
        "match_id": id,
        "date": date.toIso8601String(),
        "hour": hour,
        "pitch": pitch,
        "is_pitch_approved": isPitchApproved,
        "show_on_table": showOnTable,
        "people_limit": peopleLimit,
      },
      method: Method.post,
    );

    if (response == null) {
      //TODO
      print("null response editTeam");
      return null;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status editTeam");
      print(response.body);
      return null;
    }

    var jsonData = json.decode(response.body);
    print("createTeam");
    print(jsonData);
    if (jsonData["match"] != null) {
      return MatchModel.fromJson(jsonData["match"]);
    }

    return null;
  }

  static Future<bool> removeMatch({
    required String id,
  }) async {
    Response? response = await BilfootClient().sendRequest(
      path: "match/remove-match",
      body: {
        "match_id": id,
      },
      method: Method.post,
    );

    if (response == null) {
      //TODO
      print("null response removeMatch");
      return false;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status removeMatch");
      print(response.body);
      return false;
    }

    return true;
  }
}
