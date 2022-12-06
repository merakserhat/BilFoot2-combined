import 'dart:convert';

import 'package:bilfoot/data/models/notification_model.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:http/http.dart';

class UserService {
  static void test() {}

  static Future<bool> registerUser({
    required String email,
    required List<String> specialSkills,
    required List<String> preferredPositions,
    required List<String> dominantFeet,
    required String firebaseId,
  }) async {
    Response? response = await BilfootClient().sendRequest(
      path: "auth/register-user",
      body: {
        "email": email,
        "special_skills": specialSkills,
        "preferred_positions": preferredPositions,
        "dominant_feet": dominantFeet,
        "firebase_id": firebaseId
      },
      method: Method.post,
    );

    if (response == null) {
      //TODO
      print("null responde register");
      return false;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status register");
      print(response.body);
      return false;
    }

    return true;
  }

  static Future<PlayerModel?> getHomeData() async {
    Response? response =
        await BilfootClient().sendRequest(path: "player/get-home-data");

    if (response == null) {
      //TODO
      print("null responde getHomeData");
      return null;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status getHomeData");
      print(response.body);
      return null;
    }

    var jsonData = json.decode(response.body);
    print("getHomeData");
    print(jsonData);
    if (jsonData["player"] != null) {
      PlayerModel playerModel = PlayerModel.fromJson(jsonData["player"]);
      Program.program.user = playerModel;
      return playerModel;
    }

    return null;
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
    if (jsonData["notifications"] != null) {
      List<NotificationModel> notifications =
          (jsonData["notifications"] as List<dynamic>)
              .map((e) => NotificationModel.fromJson(e))
              .toList();

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

  static Future<bool> answerToNotification({
    required String notificationId,
    required String answer,
  }) async {
    Response? response = await BilfootClient().sendRequest(
      path: "player/answer-to-notification",
      body: {
        "notification_id": notificationId,
        "answer": answer,
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
      print("error status answer notification");
      print(response.body);
      return false;
    }

    return true;
  }

  static Future<bool> updatePhoneNumber({required String phoneNumber}) async {
    Response? response = await BilfootClient().sendRequest(
      path: "player/update-player-phone-number",
      body: {
        "phone_number": phoneNumber,
      },
      method: Method.post,
    );

    if (response == null) {
      //TODO
      print("null response updatePhoneNumber");
      return false;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status answer updatePhoneNumber");
      print(response.body);
      return false;
    }

    print(response.body);
    //UPDATE user
    Program.program.user!.phoneNumber = phoneNumber;
    return true;
  }

  static Future<String?> getPhoneNumber({required String userId}) async {
    Response? response = await BilfootClient()
        .sendRequest(path: "player/get-player-phone-number?user_id=$userId");

    if (response == null) {
      //TODO
      print("null responde getPhoneNumber");
      return null;
    }

    if (response.statusCode >= 400) {
      //TODO
      print("error status getPhoneNumber");
      print(response.body);
      return null;
    }

    var jsonData = json.decode(response.body);
    print(jsonData);
    if (jsonData["phone_number"] != null) {
      return jsonData["phone_number"];
    }

    return null;
  }
}
