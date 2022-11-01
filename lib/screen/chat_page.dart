import 'package:chat_app/models/message.dart';
import 'package:chat_app/widget/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'chatPage';
  CollectionReference message =
      FirebaseFirestore.instance.collection('message');
  TextEditingController controller = TextEditingController();
  final _Controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: message.orderBy('createdAt', descending: true).snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<MessageMolel> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(MessageMolel.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: const Color(0xFF2B475E),
                title: const Text('Chat App'),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _Controller,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return messageList[index].id == email
                              ? ChatBuble(
                                  message: messageList[index],
                                )
                              : ChatBubleFriend(message: messageList[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        message.add(
                          {
                            'message': data,
                            'createdAt': DateTime.now(),
                            'id': email
                          },
                        );
                        controller.clear();
                        _Controller.animateTo(0,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn);
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Color(0xFF2B475E))),
                          suffixIcon: Icon(Icons.send_rounded),
                          hintText: 'Send Message',
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF2B475E)),
                              borderRadius: BorderRadius.circular(16))),
                      // cursorColor: Colors.white,
                    ),
                  )
                ],
              ));
        } else {
          return Text('Looding');
        }
      }),
    );
  }
}
