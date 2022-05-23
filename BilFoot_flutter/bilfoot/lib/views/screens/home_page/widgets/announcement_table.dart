import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/views/widgets/toggle_switch_menu.dart';
import 'package:flutter/material.dart';

class AnnouncementTable extends StatefulWidget {
  const AnnouncementTable({Key? key}) : super(key: key);

  @override
  State<AnnouncementTable> createState() => _AnnouncementTableState();
}

class _AnnouncementTableState extends State<AnnouncementTable> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ToggleSwitchMenu(
            options: const ["Player", "Opponent", "Match"],
            onToggleChanged: (index, value) {
              //TODO: change index
            },
          ),
          const SizedBox.square(dimension: 10),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: ProgramConstants.getDefaultBoxShadow(context),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(); //TODO: buraya list item
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
