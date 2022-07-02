import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:bilfoot/views/widgets/page_title.dart';
import 'package:bilfoot/views/widgets/title_image_card.dart';
import 'package:flutter/material.dart';

class SkillSelectionPage extends StatefulWidget {
  const SkillSelectionPage({Key? key, this.onCallback}) : super(key: key);

  final Function(List<String> skills, List<String> dominantFeet)? onCallback;

  @override
  State<SkillSelectionPage> createState() => _SkillSelectionPageState();
}

class _SkillSelectionPageState extends State<SkillSelectionPage> {
  final List<Map<String, String>> skills = [
    {"label": "Speedy", "image": "speedy.png"},
    {"label": "Deadly Finisher", "image": "deadly_finisher.png"},
    {"label": "Playmaker", "image": "playmaker.png"},
    {"label": "Tireless", "image": "tireless.png"},
    {"label": "Long Distance", "image": "long_distance.png"},
    {"label": "Strong", "image": "strong.png"},
    {"label": "Headshot", "image": "headshot.png"},
    {"label": "Creative", "image": "creative.png"},
  ];

  List<String> selectedSkills = [];
  List<String> dominantFeet = ["Right"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Padding(
        padding: ProgramConstants.pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const PageTitle(title: "Dominant Foot"),
            const SizedBox.square(dimension: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleImageCard(
                  label: "Left",
                  isSelected: dominantFeet.contains("Left"),
                  imagePath: "assets/images/skill_icons/left_foot.png",
                  onClicked: handleFootSelected,
                ),
                const SizedBox.square(dimension: 5),
                TitleImageCard(
                  label: "Right",
                  isSelected: dominantFeet.contains("Right"),
                  imagePath: "assets/images/skill_icons/right_foot.png",
                  onClicked: handleFootSelected,
                )
              ],
            ),
            const SizedBox.square(dimension: 40),
            const PageTitle(title: "Define Yourself"),
            const SizedBox.square(dimension: 20),
            Wrap(
                direction: Axis.horizontal,
                spacing: 12,
                runSpacing: 16,
                children: skills
                    .map(
                      (e) => TitleImageCard(
                          isSelected: selectedSkills.contains(e["label"]),
                          onClicked: handleSkillClicked,
                          imagePath: "assets/images/skill_icons/${e["image"]}",
                          label: e["label"]!),
                    )
                    .toList()),
            const SizedBox.square(dimension: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (widget.onCallback != null) {
                    widget.onCallback!(selectedSkills, dominantFeet);
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text("Save Profile"),
                ),
              ),
            ),
            const SizedBox.square(dimension: 20),
          ],
        ),
      ),
    );
  }

  void handleSkillClicked(String label) {
    if (selectedSkills.contains(label)) {
      selectedSkills.remove(label);
    } else {
      selectedSkills.add(label);
    }

    setState(() {});
  }

  void handleFootSelected(String label) {
    if (dominantFeet.contains(label)) {
      if (dominantFeet.length == 1) return;
      dominantFeet.remove(label);
    } else {
      dominantFeet.add(label);
    }

    setState(() {});
  }
}
