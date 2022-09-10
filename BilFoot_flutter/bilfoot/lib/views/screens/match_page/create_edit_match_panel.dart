import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:bilfoot/views/screens/match_page/bloc/match_bloc.dart';
import 'package:bilfoot/views/screens/match_page/match_detailed_page.dart';
import 'package:bilfoot/views/screens/match_page/widgets/date_picker.dart';
import 'package:bilfoot/views/screens/match_page/widgets/match_hour_selector.dart';
import 'package:bilfoot/views/screens/match_page/widgets/pitch_selector.dart';
import 'package:bilfoot/views/screens/match_page/widgets/publish_checkbox.dart';
import 'package:bilfoot/views/screens/match_page/widgets/reserved_checkbox.dart';
import 'package:bilfoot/views/widgets/modals/remove_match_modal.dart';
import 'package:bilfoot/views/widgets/panel_base.dart';
import 'package:bilfoot/views/widgets/spinners/spinner_small.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

class CreateEditMatchPanel extends StatefulWidget {
  const CreateEditMatchPanel({Key? key, this.prevMatch, this.onMatchEdited})
      : super(key: key);

  final MatchModel? prevMatch;
  final Function(MatchModel matchModel)? onMatchEdited;

  @override
  State<CreateEditMatchPanel> createState() => _CreateEditMatchPanelState();
}

class _CreateEditMatchPanelState extends State<CreateEditMatchPanel> {
  bool isReserved = false;
  bool isPublish = true;
  int peopleLimit = 12;
  String selectedPitch = "Merkez 1";
  String selectedHour = "??-??";
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.prevMatch != null) {
      isReserved = widget.prevMatch!.isPitchApproved;
      isPublish = widget.prevMatch!.showOnTable;
      peopleLimit = widget.prevMatch!.peopleLimit;
      selectedPitch = widget.prevMatch!.pitch;
      selectedHour = widget.prevMatch!.hour;
      selectedDate = widget.prevMatch!.date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PanelBase(
        child: Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 6,
              child: DatePicker(
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
                selectedDate: selectedDate,
                setSelectedDate: (DateTime date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
            ),
            const SizedBox.square(dimension: 10),
            Flexible(
              flex: 4,
              child: MatchHourSelector(
                  onChanged: (String? hour) {
                    if (hour != null) {
                      setState(() {
                        selectedHour = hour;
                        if (selectedHour == "??-??") {
                          isReserved = false;
                        }
                      });
                    }
                  },
                  selectedHour: selectedHour),
            )
          ],
        ),
        const SizedBox.square(dimension: 20),
        PitchSelector(
          onChanged: (value) {
            setState(() {
              selectedPitch = value;
            });
          },
          selectedPitch: selectedPitch,
        ),
        const SizedBox.square(dimension: 20),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("People Limit: "),
              SizedBox(
                width: 150,
                child: NumberPicker(
                    minValue: 1,
                    maxValue: 20,
                    axis: Axis.horizontal,
                    itemWidth: 50,
                    value: peopleLimit,
                    onChanged: (value) {
                      setState(() {
                        peopleLimit = value;
                      });
                    }),
              ),
            ],
          ),
        ),
        const SizedBox.square(dimension: 20),
        ReservedCheckbox(
          onChanged: (value) {
            setState(() {
              isReserved = value ?? false;
            });
          },
          defaultValue: isReserved,
          disabled: selectedHour == "??-??",
        ),
        const SizedBox.square(dimension: 20),
        PublishCheckbox(
          onChanged: (value) {
            setState(() {
              isPublish = value ?? true;
            });
          },
          defaultValue: isPublish,
        ),
        const SizedBox.square(dimension: 20),
        isLoading
            ? SpinnerSmall()
            : Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (widget.prevMatch == null) {
                        createMatch();
                      } else {
                        editMatch();
                      }
                    },
                    child: Text(widget.prevMatch == null ? "Create" : "Edit"),
                  ),
                  widget.prevMatch == null
                      ? Container()
                      : TextButton(
                          onPressed: () async {
                            ProgramConstants.showBlurryBackground(
                              context: context,
                              child: RemoveMatchModal(
                                onAccepted: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Navigator.of(context).pop();

                                  bool isSuccess = await BilfootClient()
                                      .removeMatch(id: widget.prevMatch!.id);

                                  if (isSuccess) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    context
                                        .read<MatchBloc>()
                                        .add(MatchGetMatches());
                                  }
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Remove Match",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Theme.of(context).errorColor),
                          ))
                ],
              ),
        const SizedBox.square(dimension: 10),
      ],
    ));
  }

  createMatch() async {
    setState(() {
      isLoading = true;
    });

    MatchModel? matchModel = await BilfootClient().createMatch(
        date: selectedDate,
        hour: selectedHour,
        isPitchApproved: isReserved,
        peopleLimit: peopleLimit,
        pitch: selectedPitch,
        showOnTable: isPublish);

    if (matchModel != null) {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => MatchDetailedPage(match: matchModel)));
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void editMatch() async {
    setState(() {
      isLoading = true;
    });

    MatchModel? matchModel = await BilfootClient().editMatch(
        id: widget.prevMatch!.id,
        date: selectedDate,
        hour: selectedHour,
        isPitchApproved: isReserved,
        peopleLimit: peopleLimit,
        pitch: selectedPitch,
        showOnTable: isPublish);

    if (matchModel != null) {
      Navigator.of(context).pop();
      widget.onMatchEdited!(matchModel);
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
