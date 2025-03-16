import 'package:chatapp_2025/pages/chat/widgets/chat_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [
    Message(
      text: "text",
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isMe: true,
    ),
    Message(
      text: "hello",
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isMe: true,
    ),
    Message(
      text: "Hell, yes sir I'am good but i need some time for reload my healt",
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isMe: true,
    ),
    Message(
      text: "Hell, yes sir I'am good but i need some time for reload my healt",
      date: DateTime.now().subtract(Duration(days: 180)),
      isMe: false,
    ),
    Message(
      text: "hhhhhhhhhhh",
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isMe: true,
    ),
    Message(
      text: "Hello hello hello hello hello ",
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isMe: false,
    ),
    Message(
      text: "text",
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isMe: true,
    ),
    Message(
      text: "hello",
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isMe: true,
    ),
    Message(
      text: "Hell, yes sir I'am good but i need some time for reload my healt",
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isMe: true,
    ),
    Message(
      text: "Hell, yes sir I'am good but i need some time for reload my healt",
      date: DateTime.now().subtract(Duration(days: 180)),
      isMe: false,
    ),
    Message(
      text: "hhhhhhhhhhh",
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isMe: true,
    ),
    Message(
      text: "Hello hello hello hello hello ",
      date: DateTime.now().subtract(Duration(minutes: 1)),
      isMe: false,
    ),
  ];

  final ScrollController _scrollController = ScrollController();
  TextEditingController _textMessageController = TextEditingController();
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    //_scrollController.addListener(_scrollControllerListener);
    _textMessageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _textMessageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollControllerListener() {
    if (_isKeyboardVisible) {
      // Scroll to the bottom when the keyboard is visible
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Container(
        //padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                child: GroupedListView<Message, DateTime>(
                  elements: messages,
                  groupBy:
                      (message) => DateTime(
                        message.date.year,
                        message.date.month,
                        message.date.day,
                      ),
                  groupHeaderBuilder:
                      (Message message) => Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20, top: 20),
                          padding: EdgeInsets.all(8.h),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            DateFormat.yMMMd().format(message.date),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                  indexedItemBuilder:
                      (context, element, index) => Align(
                        alignment:
                            element.isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: MessageTextWidget(element.text, element.isMe),
                      ),
                ),
              ),
            ),
            createMessageInputComponent(context, _textMessageController),
          ],
        ),
      ),
    );
  }
}
