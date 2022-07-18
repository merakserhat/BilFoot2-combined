import 'dart:convert';

import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TeamService {
  static void test() {}

  static Future<TeamModel?> getTeamModel({required String id}) async {
    Response? response = await BilfootClient().sendRequest(
      path: "team/get-team-model?id=$id",
    );

    if (response == null) {
      //TODO
      print("null response createTeam");
      return null;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status get team model");
      print(response.body);
      return null;
    }

    var jsonData = json.decode(response.body);
    print("get team model");
    print(jsonData);
    if (jsonData["team_model"] != null) {
      return TeamModel.fromJson(jsonData["team_model"]);
    }

    return null;
  }

  static Future<bool> createTeam({
    required String teamName,
    required String shortName,
    required String mainColor,
    required String accentColor,
  }) async {
    Response? response = await BilfootClient().sendRequest(
      path: "team/create-team",
      body: {
        "name": teamName,
        "short_name": shortName,
        "main_color": mainColor,
        "accent_color": accentColor
      },
      method: Method.post,
    );

    if (response == null) {
      //TODO
      print("null response createTeam");
      return false;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status createTeam");
      print(response.body);
      return false;
    }

    var jsonData = json.decode(response.body);
    print("createTeam");
    print(jsonData);
    if (jsonData["team"] != null) {
      Program.program.user!.teams.add(jsonData["team"]["_id"]);
      return true;
    }

    return false;
  }

  static Future<bool> getTeamInvitation({
    required String fromId,
    required String toId,
  }) async {
    Response? response = await BilfootClient().sendRequest(
      path: "team/get-team-invitation?from_id=$fromId&to_id=$toId",
    );

    if (response == null) {
      //TODO
      print("null response get team invitation");
      return false;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status get team invitation");
      print(response.body);
      return false;
    }

    var jsonData = json.decode(response.body);
    print("get team invitation");
    print(jsonData);
    if (jsonData["invitation"] != null) {
      return true;
    }

    return false;
  }

  static Future<bool> inviteToTeam({
    required String teamId,
    required String toId,
  }) async {
    Response? response = await BilfootClient().sendRequest(
      path: "team/invite-to-team",
      body: {
        "team_id": teamId,
        "to_id": toId,
      },
      method: Method.post,
    );

    if (response == null) {
      //TODO
      print("null response inviteToTeam");
      return false;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status inviteToTeam");
      print(response.body);
      return false;
    }

    print(response.body);
    return true;
  }
}
