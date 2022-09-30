import 'package:bilfoot/data/models/player_model.dart';
import 'package:intl/intl.dart';

class MatchModel {
  MatchModel({
    required this.id,
    required this.date,
    required this.hour,
    required this.pitch,
    required this.isPitchApproved,
    required this.creator,
    required this.players,
    required this.authPlayers,
    required this.showOnTable,
    required this.peopleLimit,
  });
  late final String id;
  late final DateTime date;
  late final String hour;
  late final String pitch;
  late final bool isPitchApproved;
  late final PlayerModel creator;
  late final List<PlayerModel> players;
  late final List<String> authPlayers;
  late final bool showOnTable;
  late final int peopleLimit;

  MatchModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    date = DateTime.parse(json['date']);
    hour = json['hour'];
    pitch = json['pitch'];
    isPitchApproved = json['is_pitch_approved'];
    creator = PlayerModel.fromJson(json["creator"]);
    players =
        List.from(json["players"]).map((e) => PlayerModel.fromJson(e)).toList();
    authPlayers = List.castFrom<dynamic, String>(json['auth_players']);
    showOnTable = json['show_on_table'];
    peopleLimit = json['people_limit'];
  }

  static String formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    final DateFormat formatter = DateFormat('d MMMM E');
    return formatter.format(dateTime);
  }

  static String formatSquareMatchDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    final DateFormat formatter = DateFormat('d MMMM');
    return formatter.format(dateTime);
  }

  @override
  String toString() {
    return "auth_players: $authPlayers";
  }
}
