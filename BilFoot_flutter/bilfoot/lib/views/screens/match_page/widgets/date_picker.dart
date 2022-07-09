import 'package:bilfoot/config/constants/program_constants.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime) setSelectedDate;
  const DatePicker(
      {Key? key,
      required this.selectedDate,
      required this.firstDate,
      required this.lastDate,
      required this.setSelectedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: ProgramConstants.getDefaultBoxShadow(context),
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      child: Material(
        child: InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: firstDate,
                lastDate: lastDate);

            if (picked != null) {
              setSelectedDate(picked);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  _getDateText(),
                  overflow: TextOverflow.fade,
                )),
                const Icon(
                  Icons.date_range_outlined,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getDateText() {
    var monthFormatter = DateFormat(DateFormat.ABBR_MONTH);
    var dayFormatter = DateFormat(DateFormat.WEEKDAY);
    return '${selectedDate.day} ${monthFormatter.format(selectedDate)} ${dayFormatter.format(selectedDate)}';
  }
}
