import 'dart:convert';

import 'package:bilfoot/data/models/notification_model.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:http/http.dart';

class UserService {
  static void test() {}

  static Future<bool> getHomeData() async {
    Response? response =
        await BilfootClient().sendRequest(path: "player/get-home-data");

    if (response == null) {
      //TODO
      print("null responde getHomeData");
      return false;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status getHomeData");
      return false;
    }

    var jsonData = json.decode(response.body);
    print("getHomeData");
    print(jsonData);
    if (jsonData["player"] != null) {
      PlayerModel playerModel = PlayerModel.fromJson(jsonData["player"]);
      Program.program.user = playerModel;
      return true;
    }

    return false;
  }

  static Future<bool> getUserNotifications() async {
    Response? response = await BilfootClient()
        .sendRequest(path: "player/get-player-notifications");

    if (response == null) {
      //TODO
      print("null responde getHomeData");
      return false;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status getUserNotifications");
      return false;
    }

    var jsonData = json.decode(response.body);
    print(jsonData);
    if (jsonData["detailed_notifications"] != null) {
      List<NotificationModel> notifications =
          NotificationModel.splitDetailedNotifications(jsonData);

      Program.program.notifications = notifications;
      return true;
    }

    return false;
  }

  static Future<List<PlayerModel>> searchPlayers(
      {required String value}) async {
    Response? response = await BilfootClient().sendRequest(
      path: "player/search-players?value=$value",
    );

    if (response == null) {
      //TODO
      print("null response createTeam");
      return [];
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status get team model");
      print(response.body);
      return [];
    }

    var jsonData = json.decode(response.body);
    print("get team model");
    print(jsonData);
    if (jsonData["players"] != null) {
      return List.from(jsonData['players'])
          .map((e) => PlayerModel.fromJson(e))
          .toList();
    }

    return [];
  }
}
