import 'package:bilfoot/data/models/notification_model.dart';
import 'package:bilfoot/views/screens/match_page/match_detailed_page.dart';
import 'package:bilfoot/views/screens/profile_page/profile_page.dart';
import 'package:bilfoot/views/screens/profile_page/widgets/profile_page_photo.dart';
import 'package:bilfoot/views/screens/team_page/team_page.dart';
import 'package:bilfoot/views/screens/team_page/widgets/team_logo_title.dart';
import 'package:bilfoot/views/widgets/markup_text.dart';
import 'package:bilfoot/views/widgets/match_logo.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatefulWidget {
  final NotificationModel notificationModel;
  const NotificationCard({Key? key, required this.notificationModel})
      : super(key: key);

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _getColor(),
      child: InkWell(
        onTap: _handleClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: FittedBox(
                  child: _getLeadingIcon(),
                ),
              ),
              const SizedBox.square(dimension: 10),
              Expanded(
                child: Column(
                  children: [
                    MarkupText(
                      _getText(),
                      textStyles: [Theme.of(context).textTheme.bodyText2!],
                    ),
                    const SizedBox.square(dimension: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getActions(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getLeadingIcon() {
    if (widget.notificationModel.teamModel != null) {
      return TeamLogoTitle(
        teamModel: widget.notificationModel.teamModel!,
        bigLogo: true,
      );
    } else if (widget.notificationModel.matchModel != null) {
      return MatchLogo(matchModel: widget.notificationModel.matchModel!);
    } else if (widget.notificationModel.playerModel != null) {
      return ProfilePagePhoto(
          playerModel: widget.notificationModel.playerModel!);
    }

    return Container();
  }

  String _getText() {
    return "Şimdilik burası [b]admin[] için bir deneme [#ff0000]notification[] testi.";
  }

  List<Widget> _getActions() {
    if (widget.notificationModel.interaction == "chat") {
      return [
        ElevatedButton(
          onPressed: () {
            //TODO: chat
          },
          child: const Text("Write Message"),
        ),
      ];
    } else if (widget.notificationModel.interaction == "approval") {
      if (widget.notificationModel.status == "vending") {
        return [
          OutlinedButton(
              onPressed: () {
                setState(() {
                  widget.notificationModel.status = "refused";
                });
              },
              child: const Text("Refuse")),
          const SizedBox.square(dimension: 32),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.notificationModel.status = "accepted";
                });
              },
              child: const Text("Accept")),
        ];
      } else {
        return [
          Expanded(child: Container()),
          Text(
            widget.notificationModel.status,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                color: widget.notificationModel.status == "refused"
                    ? Colors.red
                    : Colors.green),
          )
        ];
      }
    }

    return [];
  }

  void _handleClick() {
    if (widget.notificationModel.teamModel != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              TeamPage(team: widget.notificationModel.teamModel!)));
    } else if (widget.notificationModel.playerModel != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ProfilePage(
                playerModel: widget.notificationModel.playerModel,
              )));
    } else if (widget.notificationModel.matchModel != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              MatchDetailedPage(match: widget.notificationModel.matchModel!)));
    }
  }

  Color _getColor() {
    if (widget.notificationModel.status == "accepted") {
      return Colors.green.withOpacity(0.1);
    }

    if (widget.notificationModel.status == "refused") {
      return Colors.red.withOpacity(0.1);
    }

    return Colors.white;
  }
}
