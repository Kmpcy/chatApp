import 'package:chat_app_sholar/constants.dart';
import 'package:chat_app_sholar/models/message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
   required this.message
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.only(left: 19, bottom: 16, top: 16, right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(36),
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
            color:  Color(0xff006D84)),
        child: Text(message.message,
            style: TextStyle(color: Colors.white, fontSize: 14.6, height: .9)),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({
   required this.message
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.only(left: 19, bottom: 16, top: 16, right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
            color:kPrimaryColor),
        child: Text(message.message,
            style: TextStyle(color: Colors.white, fontSize: 14.6, height: .9)),
      ),
    );
  }
}

