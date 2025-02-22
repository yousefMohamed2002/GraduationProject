import 'package:flutter/material.dart';

import '../Bottom_Bar/custom_bottom_nav_bar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('calender Page'),
      ),
      body: Center(
        child: Text('Welcome to the calender Page!'),
      ),bottomNavigationBar: CustomBottomNavBar(selectedIndex: 1),
    );
  }
}
