import 'package:chat_app_sholar/constants.dart';
import 'package:chat_app_sholar/models/message.dart';
import 'package:chat_app_sholar/pages/Login_page.dart';
import 'package:chat_app_sholar/pages/Register_page.dart';
import 'package:chat_app_sholar/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = "ChatPage";
  TextEditingController Controller = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromjson(snapshot.data!.docs[i]));
            }

            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                automaticallyImplyLeading: false,
                title:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(logoApp, height: 54),
                  Text(
                    "Chat",
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  )
                ]),
              ),
              body:
               Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].id==email? ChatBubble(
                            message: messagesList[index]):ChatBubbleForFriend(message: messagesList[index])
                          ;
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.5),
                    child: TextField(
                      controller: Controller,
                      onSubmitted: (data) {
                        messages
                            .add({"message": data,"id": email,
                             kCreatedAt: DateTime.now()});
                        Controller.clear();

                        _scrollController.animateTo(
                          0,
                          duration: Duration(milliseconds: 650),
                          curve: Curves.linear,
                        );
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: kPrimaryColor,
                        suffixIcon: Icon(Icons.send, color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: " Message",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: kPrimaryColor)),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return RegisterPage();
          }
        });
  }
}
