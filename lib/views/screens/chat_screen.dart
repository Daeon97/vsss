// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:vsss/resources/strings.dart';
import 'package:vsss/views/widgets/screen_scaffold.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) => ScreenScaffold(
        centerScrollViewVertically: false,
        title: chatLiteral,
        child: Column(
          children: [],
        ),
      );
}
