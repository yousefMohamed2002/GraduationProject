import 'package:flutter/material.dart';

import '../Screens/utilits/Bottom_Bar/custom_bottom_nav_bar.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatBot'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),bottomNavigationBar: CustomBottomNavBar(selectedIndex: 0)
    );
  }
}
