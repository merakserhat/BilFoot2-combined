import 'package:bilfoot/config/utils/auth_service.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/views/screens/auth_page/bloc/authentication_bloc.dart';
import 'package:bilfoot/views/screens/first_page/first_page.dart';
import 'package:bilfoot/views/screens/profile_page/widgets/profile_page_photo.dart';
import 'package:bilfoot/views/screens/profile_page/widgets/profile_skills_table.dart';
import 'package:bilfoot/views/screens/profile_page/widgets/team_list_card.dart';
import 'package:bilfoot/views/screens/team_page/bloc/team_bloc.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = "profile_page";
  final PlayerModel? playerModel;

  const ProfilePage({Key? key, this.playerModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: playerModel == null ? null : const BasicAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              const SizedBox.square(dimension: 20),
              ProfilePagePhoto(
                  playerModel: playerModel ?? Program.program.user!),
              const SizedBox.square(dimension: 30),
              ProfileSkillsTable(
                  playerModel: playerModel ?? Program.program.user!),
              const SizedBox.square(dimension: 30),
              BlocBuilder<TeamBloc, TeamState>(builder: (context, state) {
                return TeamListCard(
                    playerModel: playerModel ?? Program.program.user!,
                    isStrangerView: playerModel != null);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
