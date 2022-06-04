import mongoose from "mongoose";
const { ObjectId, Date } = mongoose;

const matchAnnouncementSchema = new mongoose.Schema({
  announcer: { type: ObjectId, required: true },
  date: { type: Date, required: true },
});

export default mongoose.model("match_announcement", matchAnnouncementSchema);

/*

import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/player_model.dart';

class MatchAnnouncementModel {
  MatchAnnouncementModel({
    required this.announcer,
    this.match,
    required this.date,
  });
  late final PlayerModel announcer;
  late final MatchModel? match;
  late final DateTime date;

  MatchAnnouncementModel.fromJson(Map<String, dynamic> json) {
    announcer = PlayerModel.fromJson(json['pitch']);
    match =
        json['match'] == null ? null : MatchModel.fromJson(json['matchTime']);
    DateTime dataDate = DateTime.parse(json['date']);
    date = DateTime(dataDate.year, dataDate.month, dataDate.day);
  }
}


*/
