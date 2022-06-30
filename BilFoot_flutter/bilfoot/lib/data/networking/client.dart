import 'package:bilfoot/data/networking/announcement_service.dart';
import 'package:bilfoot/data/networking/chat_service.dart';
import 'package:bilfoot/data/networking/team_service.dart';
import 'package:bilfoot/data/networking/user_service.dart';

class BilfootClient {
  static final BilfootClient _instance = BilfootClient._internal();
  BilfootClient._internal();

  factory BilfootClient() {
    return _instance;
  }

  //get ip by writing ipconfig to terminal
  final String baseUrl = "http://192.168.1.101:8080/";

  //User endpoints
  final userTest = UserService.test;

  //Chat endpoints
  final chatTest = ChatService.test;

  //Team endpoints
  final teamTest = TeamService.test;

  //Announcement endpoints
  final announcementTest = AnnouncementService.test;
}
