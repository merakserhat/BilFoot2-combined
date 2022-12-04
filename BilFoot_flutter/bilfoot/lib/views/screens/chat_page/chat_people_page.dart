import 'package:bilfoot/config/constants/program_constants.dart';
import 'package:bilfoot/data/models/conversation_model.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/views/screens/chat_page/chat_page.dart';
import 'package:bilfoot/views/widgets/basic_app_bar.dart';
import 'package:bilfoot/views/widgets/profile_photo.dart';
import 'package:flutter/material.dart';

/**
 * This page is not an active page for now.
 *
 * In order to publish this application with the core features,
 * this part should be hidden.
 */

class ChatPeoplePage extends StatefulWidget {
  const ChatPeoplePage({Key? key}) : super(key: key);

  @override
  State<ChatPeoplePage> createState() => _ChatPeoplePageState();
}

class _ChatPeoplePageState extends State<ChatPeoplePage> {
  List<ConversationModel>? conversations;

  @override
  void initState() {
    super.initState();

    //TODO:Fetch conversations, change loading spinner, use future builder
    conversations = Program.program.dummyData.conversations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Padding(
        padding: ProgramConstants.pagePadding,
        child: conversations == null
            ? const CircularProgressIndicator()
            : Column(
                children: List.generate(
                    conversations!.length,
                    (index) => ChatPersonItem(
                        conversationModel: conversations![index])).toList(),
              ),
      ),
    );
  }
}

class ChatPersonItem extends StatelessWidget {
  const ChatPersonItem({Key? key, required this.conversationModel})
      : super(key: key);
  final ConversationModel conversationModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatPage(
                  conversationModel: conversationModel,
                )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Hero(
              tag: "CHAT_PROFILE_PHOTO",
              child: SizedBox(
                width: 50,
                height: 50,
                child: ProfilePhoto(
                  imageUrl: _getPlayer().imageUrl!,
                ), //TODO: default image
              ),
            ),
            const SizedBox.square(dimension: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getPlayer().fullName,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  conversationModel.messages.isEmpty
                      ? Container()
                      : Row(
                          children: [
                            Icon(
                              _getLastMessage().fromMail ==
                                      Program.program.user!.email
                                  ? Icons.arrow_upward_outlined
                                  : Icons.arrow_downward_outlined,
                              color: _getLastMessage().fromMail ==
                                      Program.program.user!.email
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).colorScheme.secondary,
                              size: 14,
                            ),
                            const SizedBox.square(dimension: 5),
                            Text(
                              _getLastMessage().content,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.black54),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  MessageModel _getLastMessage() {
    return conversationModel.messages[conversationModel.messages.length - 1];
  }

  PlayerModel _getPlayer() {
    return conversationModel.members
        .firstWhere((element) => element.email != Program.program.user!.email);
  }
}
