import 'dart:math';

import "package:flutter/material.dart";

class PitchSelector extends StatelessWidget {
  final Function(String value) onChanged;
  final String selectedPitch;
  const PitchSelector(
      {Key? key, required this.onChanged, required this.selectedPitch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PitchItem(
          pitchName: "Merkez 1",
          isSelected: selectedPitch == "Merkez 1",
          onSelected: onSelected,
        ),
        PitchItem(
          pitchName: "Merkez 2",
          isSelected: selectedPitch == "Merkez 2",
          onSelected: onSelected,
        ),
        PitchItem(
          pitchName: "Doğu 1",
          isSelected: selectedPitch == "Doğu 1",
          onSelected: onSelected,
        ),
        PitchItem(
          pitchName: "Doğu 2",
          isSelected: selectedPitch == "Doğu 2",
          onSelected: onSelected,
        ),
      ],
    );
  }

  void onSelected(String pitchName) {
    onChanged(pitchName);
  }
}

class PitchItem extends StatelessWidget {
  final bool isSelected;
  final String pitchName;
  final Function(String) onSelected;
  const PitchItem(
      {Key? key,
      this.isSelected = false,
      required this.pitchName,
      required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          onSelected(pitchName);
        }
      },
      child: Opacity(
        opacity: isSelected ? 1 : 0.3,
        child: SizedBox(
          width: 60,
          child: Column(
            children: [
              Image.asset(
                "assets/images/pitch.png",
                color: Colors.green,
              ),
              FittedBox(
                child: Text(
                  pitchName,
                  style: Theme.of(context).textTheme.headline3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
