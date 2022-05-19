class MatchModel {
  MatchModel({
    required this.pitch,
    required this.matchTime,
    required this.date,
  });
  late final String pitch;
  late final String matchTime;
  late final DateTime date;

  MatchModel.fromJson(Map<String, dynamic> json) {
    pitch = json['pitch'];
    matchTime = json['matchTime'];
    DateTime dataDate = DateTime.parse(json['date']);
    date = DateTime(dataDate.year, dataDate.month, dataDate.day);
  }
}
