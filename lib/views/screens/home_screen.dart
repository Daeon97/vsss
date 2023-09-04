// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
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
        child: Column(
          children: [],
        ),
      );
}
