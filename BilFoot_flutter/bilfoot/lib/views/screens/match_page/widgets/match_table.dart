//TODO: Remove this
// import 'package:bilfoot/config/constants/program_constants.dart';
// import 'package:bilfoot/data/models/match_model.dart';
// import 'package:bilfoot/data/models/program.dart';
// import 'package:bilfoot/views/screens/match_page/widgets/match_list_item.dart';
// import 'package:flutter/material.dart';
//
// class MatchTable extends StatefulWidget {
//   const MatchTable({Key? key}) : super(key: key);
//
//   @override
//   State<MatchTable> createState() => _MatchTableState();
// }
//
// class _MatchTableState extends State<MatchTable> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           boxShadow: ProgramConstants.getDefaultBoxShadow(context),
//           borderRadius: BorderRadius.circular(5),
//           color: Colors.white,
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//         child: ListView.builder(
//           itemCount: 5,
//           itemBuilder: (context, index) {
//             return MatchListItem(
//               matchModel: MatchModel(
//                   id: "12d",
//                   date: DateTime.now(),
//                   hour: "9-10",
//                   pitch: "Merkez 1",
//                   isPitchApproved: false,
//                   creator: Program.program.dummyPlayer2,
//                   players: [
//                     Program.program.dummyPlayer2,
//                     Program.program.dummyPlayer1
//                   ],
//                   authPlayers: [Program.program.dummyPlayer2.id],
//                   showOnTable: true,
//                   peopleLimit: 14),
//             ); //TODO: buraya list item
//           },
//         ),
//       ),
//     );
//   }
// }
