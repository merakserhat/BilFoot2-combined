import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/views/screens/home_page/widgets/announcement_table.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: ProgramConstants.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Announcements:",
              style:
                  Theme.of(context).textTheme.headline5!.copyWith(fontSize: 20),
            ),
            const SizedBox.square(dimension: 10),
            const AnnouncementTable(),
            const SizedBox.square(dimension: 20),
            Row(
              children: [
                const SizedBox.square(dimension: 5),
                _buildMyAnnouncementsButton(context),
                const SizedBox.square(dimension: 10),
                _buildNewAnnouncementButton(context),
                const SizedBox.square(dimension: 5),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMyAnnouncementsButton(BuildContext context) {
    return Expanded(
      child: Material(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: () {
            //TODO: my announcements
          },
          child: SizedBox(
              height: 50,
              child: Center(
                  child: Text(
                "My Announcements",
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Colors.white),
              ))),
        ),
      ),
    );
  }

  Widget _buildNewAnnouncementButton(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () {
          //TODO: new announcement
        },
        child: const SizedBox(
          height: 50,
          width: 50,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
