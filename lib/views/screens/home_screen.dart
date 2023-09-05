// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:vsss/resources/strings.dart';
import 'package:vsss/views/widgets/screen_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => ScreenScaffold(
        centerScrollViewVertically: false,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(
            Icons.chat,
          ),
          onPressed: () => Navigator.of(context).pushNamed(
            chatScreenRoute,
          ),
        ),
        child: Column(
          children: [],
        ),
      );
}
