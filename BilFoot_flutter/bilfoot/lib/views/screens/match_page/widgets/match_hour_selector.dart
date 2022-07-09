import "package:flutter/material.dart";

class MatchHourSelector extends StatelessWidget {
  final Function(String?) onChanged;
  final String selectedHour;
  MatchHourSelector(
      {Key? key, required this.onChanged, required this.selectedHour})
      : super(key: key);

  final List<String> hours = [
    "??-??",
    '14.00-15.00',
    '15.00-16.00',
    '16.00-17.00',
    '17.00-18.00',
    '18.00-19.00',
    '19.00-20.00',
    '20.00-21.00',
    '21.00-22.00',
    '14.30-15.30',
    '15.30-16.30',
    '16.30-17.30',
    '17.30-18.30',
    '18.30-19.30',
    '19.30-20.30',
    '20.30-21.30',
    '21.30-22.30',
  ];

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: DropdownButton<String>(
        value: selectedHour,
        icon: const Icon(Icons.access_time),
        elevation: 16,
        underline: Container(
          height: 2,
        ),
        onChanged: onChanged,
        items: hours.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
