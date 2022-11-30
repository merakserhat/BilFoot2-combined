import 'package:bilfoot/data/models/announcements/player_announcement_model.dart';
import 'package:bilfoot/data/models/conversation_model.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/team_model.dart';

class DummyData {
  late final PlayerModel dummyPlayer1,
      dummyPlayer2,
      dummyPlayer3,
      boran,
      ayberk,
      memduh,
      mete,
      kerem,
      defans,
      ali;

  late final TeamModel dummyTeam1;

  late final List<ConversationModel> conversations;

  late final MatchModel dummyMatch1;

  late final PlayerAnnouncementModel dummyPlayerAnnouncement;

  DummyData() {
    initializePlayersAndTeams();
    initializeMatches();
    initializeConversations();
    initializePlayerAnnouncement();
  }

  void initializePlayersAndTeams() {
    dummyPlayer1 = PlayerModel(
        id: "",
        email: "ayberk.senguder@ug.bilkent.edu.tr",
        fullName: "Ayberk Şengüder",
        preferredPositions: ["GK", "St"],
        specialSkills: ["Tireless", "Playmaker"],
        averagePoint: 4.6,
        pointerNum: 17,
        teams: [],
        matches: [],
        imageUrl:
            "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

    dummyPlayer2 = PlayerModel(
        id: "",
        email: "serhat.merak@ug.bilkent.edu.tr",
        fullName: "Serhat Merak",
        preferredPositions: ["GK", "St"],
        specialSkills: ["Tireless", "Playmaker"],
        averagePoint: 4.6,
        pointerNum: 17,
        teams: [],
        matches: [],
        imageUrl:
            "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

    dummyPlayer3 = PlayerModel(
        id: "",
        email: "mirza.atalar@ug.bilkent.edu.tr",
        fullName: "Mirza Atalar",
        preferredPositions: ["GK", "St"],
        specialSkills: ["Tireless", "Playmaker"],
        averagePoint: 4.6,
        pointerNum: 17,
        teams: [],
        matches: [],
        imageUrl:
            "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

    boran = PlayerModel(
        id: "",
        email: "mirza.atalar@ug.bilkent.edu.tr",
        fullName: "Boran Sarı",
        preferredPositions: ["GK", "St"],
        specialSkills: ["Tireless", "Playmaker"],
        averagePoint: 4.6,
        pointerNum: 17,
        teams: [],
        matches: [],
        imageUrl:
            "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

    ali = PlayerModel(
        id: "",
        email: "mirza.atalar@ug.bilkent.edu.tr",
        fullName: "Ali Cu",
        preferredPositions: ["GK", "St"],
        specialSkills: ["Tireless", "Playmaker"],
        averagePoint: 4.6,
        pointerNum: 17,
        teams: [],
        matches: [],
        imageUrl:
            "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

    mete = PlayerModel(
        id: "",
        email: "mirza.atalar@ug.bilkent.edu.tr",
        fullName: "Metehan Boge",
        preferredPositions: ["GK", "St"],
        specialSkills: ["Tireless", "Playmaker"],
        averagePoint: 4.6,
        pointerNum: 17,
        teams: [],
        matches: [],
        imageUrl:
            "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

    ayberk = PlayerModel(
        id: "",
        email: "mirza.atalar@ug.bilkent.edu.tr",
        fullName: "Ayberk Şengüder",
        preferredPositions: ["GK", "St"],
        specialSkills: ["Tireless", "Playmaker"],
        averagePoint: 4.6,
        pointerNum: 17,
        teams: [],
        matches: [],
        imageUrl:
            "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

    memduh = PlayerModel(
        id: "",
        email: "mirza.atalar@ug.bilkent.edu.tr",
        fullName: "Memduh Tutuş",
        preferredPositions: ["GK", "St"],
        specialSkills: ["Tireless", "Playmaker"],
        averagePoint: 4.6,
        pointerNum: 17,
        teams: [],
        matches: [],
        imageUrl:
            "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

    kerem = PlayerModel(
        id: "",
        email: "mirza.atalar@ug.bilkent.edu.tr",
        fullName: "Kerem Yakay",
        preferredPositions: ["GK", "St"],
        specialSkills: ["Tireless", "Playmaker"],
        averagePoint: 4.6,
        pointerNum: 17,
        teams: [],
        matches: [],
        imageUrl:
            "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

    defans = PlayerModel(
        id: "",
        email: "mirza.atalar@ug.bilkent.edu.tr",
        fullName: "Defans Transfer",
        preferredPositions: ["GK", "St"],
        specialSkills: ["Tireless", "Playmaker"],
        averagePoint: 4.6,
        pointerNum: 17,
        teams: [],
        matches: [],
        imageUrl:
            "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

    dummyTeam1 = TeamModel(
        id: "",
        name: "TUTUNAMAYANLAR",
        shortName: "CU",
        mainColor: "#347282",
        accentColor: "#f6f2c2",
        creator: "",
        captain: "",
        players: [ali, kerem, mete]);
  }

  initializeConversations() {
    conversations = [
      ConversationModel(
        members: [dummyPlayer1, dummyPlayer2],
        messages: [
          MessageModel(
            fromMail: "serhat.merak@ug.bilkent.edu.tr",
            content: "Deneme bir dummy mesajı",
            date: DateTime.now(),
          ),
          MessageModel(
            fromMail: "serhat.merak@ug.bilkent.edu.tr",
            content: "Gönderen serhat merak",
            date: DateTime.now(),
          ),
          MessageModel(
            fromMail: "ayberk.senguder@ug.bilkent.edu.tr",
            content: "Deneme bir response",
            date: DateTime.now(),
          ),
          MessageModel(
            fromMail: "ayberk.senguder@ug.bilkent.edu.tr",
            content: "Gönderen ayberk şengüder",
            date: DateTime.now(),
          ),
        ],
      ),
      ConversationModel(
        members: [dummyPlayer1, dummyPlayer2],
        messages: [
          MessageModel(
            fromMail: "serhat.merak@ug.bilkent.edu.tr",
            content: "Deneme bir dummy mesajı",
            date: DateTime.now(),
          ),
          MessageModel(
            fromMail: "serhat.merak@ug.bilkent.edu.tr",
            content: "Gönderen serhat merak",
            date: DateTime.now(),
          ),
          MessageModel(
            fromMail: "ayberk.senguder@ug.bilkent.edu.tr",
            content: "Deneme bir response",
            date: DateTime.now(),
          ),
          MessageModel(
            fromMail: "ayberk.senguder@ug.bilkent.edu.tr",
            content: "Gönderen ayberk şengüder",
            date: DateTime.now(),
          ),
        ],
      ),
      ConversationModel(
        members: [dummyPlayer1, dummyPlayer2],
        messages: [
          MessageModel(
            fromMail: "serhat.merak@ug.bilkent.edu.tr",
            content: "Deneme bir dummy mesajı",
            date: DateTime.now(),
          ),
          MessageModel(
            fromMail: "serhat.merak@ug.bilkent.edu.tr",
            content: "Gönderen serhat merak",
            date: DateTime.now(),
          ),
          MessageModel(
            fromMail: "ayberk.senguder@ug.bilkent.edu.tr",
            content: "Deneme bir response",
            date: DateTime.now(),
          ),
          MessageModel(
            fromMail: "ayberk.senguder@ug.bilkent.edu.tr",
            content: "Gönderen ayberk şengüder",
            date: DateTime.now(),
          ),
          MessageModel(
            fromMail: "serhat.merak@ug.bilkent.edu.tr",
            content: "Anlaşıldı tamam",
            date: DateTime.now(),
          ),
        ],
      ),
    ];
  }

  void initializeMatches() {
    dummyMatch1 = MatchModel(
        id: "12s",
        date: DateTime.now(),
        hour: "9-10",
        pitch: "Merkez 1",
        isPitchApproved: false,
        creator: dummyPlayer2,
        players: [dummyPlayer2, dummyPlayer1],
        authPlayers: [dummyPlayer2.id],
        showOnTable: true,
        peopleLimit: 14);
  }

  void initializePlayerAnnouncement() {
    dummyPlayerAnnouncement = PlayerAnnouncementModel(
        id: "1",
        announcer: ayberk,
        match: dummyMatch1,
        createdAt: DateTime.now(),
        positions: ["GK", "ST"],
        candidates: 2,
        refusedPlayers: 2,
        acceptedPlayers: 2,
        playerLimit: 4);
  }
}
