import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/screens/profile_page/widgets/profile_page_photo.dart';
import 'package:bilfoot/views/screens/profile_page/widgets/profile_skills_table.dart';
import 'package:bilfoot/views/screens/profile_page/widgets/team_list_card.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = "profile_page";

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerModel dummyPlayer2 = PlayerModel(
        email: "serhat.merak@ug.bilkent.edu.tr",
        fullName: "Serhat Merak",
        preferredPositions: ["GK", "St"],
        specialSkills: ["Tireless", "Playmaker"],
        averagePoint: 4.6,
        pointerNum: 17,
        teams: [
          TeamModel(
              name: "Cu S.K",
              shortName: "CU",
              mainColor: "#347282",
              accentColor: "#f6f2c2",
              creator: Program.program.dummyPlayer1,
              captain: Program.program.dummyPlayer1,
              players: [])
        ],
        imageUrl:
            "https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg");

    Program.program.user = dummyPlayer2;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              const SizedBox.square(dimension: 20),
              ProfilePagePhoto(playerModel: dummyPlayer2),
              const SizedBox.square(dimension: 30),
              ProfileSkillsTable(playerModel: dummyPlayer2),
              const SizedBox.square(dimension: 30),
              TeamListCard(playerModel: dummyPlayer2),
            ],
          ),
        ),
      ),
    );
  }
}
