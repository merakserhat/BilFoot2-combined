import 'package:bilfoot/data/models/conversation_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/views/screens/chat_page/widgets/chat_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/**
 * This page is not an active page for now.
 *
 * In order to publish this application with the core features,
 * this part should be hidden.
 */

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.conversationModel}) : super(key: key);

  final ConversationModel conversationModel;

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  var isSubmitted = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
          playerModel: widget.conversationModel.members.firstWhere(
              (element) => element.email != Program.program.user!.email)),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: _getMessages()),
              const Divider(),
              _getTextBar(),
            ],
          )),
    );
  }

  Widget _getTextBar() {
    const double height = 35;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(minHeight: height, maxHeight: 150),
              child: Scrollbar(
                child: TextField(
                  controller: textEditingController,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: Theme.of(context).textTheme.headline5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    hintText: "Mesajını yaz",
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox.square(dimension: 5),
          _getSendButton(height)
        ],
      ),
    );
  }

  Widget _getSendButton(double height) {
    return InkWell(
      onTap: () async {
        if (textEditingController.value.text.isNotEmpty) {
          // context
          //     .read<ChatBloc>()
          //     .add(ChatSendMessage(text: textEditingController.value.text));
          setState(() {
            widget.conversationModel.messages.add(MessageModel(
                fromMail: Program.program.user!.email,
                content: textEditingController.text,
                date: DateTime.now()));
          });
          setState(() {
            textEditingController.text = "";
          });
        }
      },
      child: Container(
          width: height,
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          margin: EdgeInsets.zero,
          child: const Icon(
            Icons.send,
            size: 16,
            color: Colors.white,
          )),
    );
  }

  final ScrollController _scrollController = ScrollController();

  Widget _getMessages() {
    //SingleChildScrollView is not a good idea to use in a chat app but
    //There won't be a huge message history so it is not a big problem
    return SingleChildScrollView(
      controller: _scrollController,
      child: Builder(
        builder: (context) {
          WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          });
          return Column(
            children: [
              ...List.generate(
                widget.conversationModel.messages.length,
                (index) => ChatBubble(
                  isContinuation: index == 0
                      ? false
                      : widget.conversationModel.messages[index].fromMail ==
                          widget.conversationModel.messages[index - 1].fromMail,
                  isOwnMessage:
                      widget.conversationModel.messages[index].fromMail ==
                          Program.program.user!.email,
                  content: widget.conversationModel.messages[index].content,
                  date: widget.conversationModel.messages[index].date,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ChatBubble extends StatefulWidget {
  final String content;
  final bool isContinuation;
  final bool isOwnMessage;
  final DateTime date;

  const ChatBubble({
    Key? key,
    this.content = "",
    this.isContinuation = false,
    this.isOwnMessage = true,
    required this.date,
  }) : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool displayingData = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          displayingData = !displayingData;
        });
      },
      child: Stack(
        children: [
          Align(
            alignment: widget.isOwnMessage
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: _getContent(content: widget.content, context: context),
          ),
        ],
      ),
    );
  }

  Widget _getContent({required String content, required BuildContext context}) {
    double maxWidth = MediaQuery.of(context).size.width;

    return Container(
      width: maxWidth * 0.6,
      margin: EdgeInsets.only(
          left: 16, right: 16, bottom: 0, top: widget.isContinuation ? 8 : 16),
      child: AnimatedSize(
        duration: Duration(milliseconds: 200),
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: widget.isOwnMessage
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: maxWidth * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: widget.isOwnMessage
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).colorScheme.secondary,
              ),
              child: Text(
                content,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(height: 1.2, color: Colors.white),
                softWrap: true,
                textAlign: TextAlign.left,
              ),
            ),
            displayingData
                ? Text(DateFormat('yyyy-MM-dd – kk:mm').format(widget.date))
                : Container(),
          ],
        ),
      ),
    );
  }
}
