import 'package:bilfoot/data/models/player_model.dart';

class ConversationModel {
  ConversationModel({
    required this.members,
    required this.messages,
  });
  late final List<PlayerModel> members;
  late final List<MessageModel> messages;

  ConversationModel.fromJson(Map<String, dynamic> json) {
    members =
        List.from(json['players']).map((e) => PlayerModel.fromJson(e)).toList();
    messages = List.from(json['messages'])
        .map((e) => MessageModel.fromJson(e))
        .toList();
  }
}

class MessageModel {
  MessageModel({
    required this.fromMail,
    required this.content,
    required this.date,
  });
  late final String fromMail;
  late final String content;
  late final DateTime date;

  MessageModel.fromJson(Map<String, dynamic> json) {
    fromMail = json['from_mail'];
    content = json['content'];
    DateTime dataDate = DateTime.parse(json['date']);
    date = DateTime(dataDate.year, dataDate.month, dataDate.day);
  }
}
