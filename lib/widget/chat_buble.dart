import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  ChatBuble({
    required this.message,
    Key? key,
  }) : super(key: key);
  MessageMolel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          padding:
              const EdgeInsets.only(top: 32, left: 16, right: 32, bottom: 32),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: const BoxDecoration(
              color: Color(0xFF2B475E),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                  bottomRight: Radius.circular(32))),
          child: Text(
            message.message,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}

class ChatBubleFriend extends StatelessWidget {
  ChatBubleFriend({
    required this.message,
    Key? key,
  }) : super(key: key);
  MessageMolel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          padding:
              const EdgeInsets.only(top: 32, left: 16, right: 32, bottom: 32),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: const BoxDecoration(
              color: Color(0xFF006D84),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32))),
          child: Text(
            message.message,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
