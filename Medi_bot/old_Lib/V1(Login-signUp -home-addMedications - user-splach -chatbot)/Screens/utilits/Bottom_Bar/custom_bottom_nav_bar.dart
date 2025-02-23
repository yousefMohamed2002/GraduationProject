/*
import 'package:flutter/material.dart';

import '../bottomBar_screens/CalendarScreen.dart';
import '../bottomBar_screens/ChatBotScreen.dart';
import '../bottomBar_screens/HomePage.dart';
import '../bottomBar_screens/profile_screen.dart';
import '../bottomBar_screens/setting_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  CustomBottomNavBar({required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          height: 70,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            if (index != selectedIndex) {
              _navigateToScreen(context, index);
            }
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.smart_toy_outlined),
              selectedIcon: Icon(Icons.smart_toy, color: Colors.blue),
              label: 'ChatBot',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_today_outlined),
              selectedIcon: Icon(Icons.calendar_today, color: Colors.blue),
              label: 'Calendar',
            ),
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: Colors.blue),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: Colors.blue),
              label: 'Profile',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings, color: Colors.blue),
              label: 'Setting',
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, int index) {
    Widget screen;
    switch (index) {
      case 0:
        screen = ChatBotScreen();
        break;
      case 1:
        screen = CalendarScreen();
        break;
      case 2:
        screen = Homepage();
        break;
      case 3:
        screen = EditProfileScreen();
        break;
      case 4:
        screen = SettingsScreen();
        break;
      default:
        screen = Homepage();
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:medi_bot/Screens/CalendarScreen.dart';
import 'package:medi_bot/Screens/ChatBotScreen.dart';
import 'package:medi_bot/Screens/HomePage.dart';
import 'package:medi_bot/Screens/profile_screen.dart';
import 'package:medi_bot/Screens/setting_screen.dart';


class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  CustomBottomNavBar({required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: 'ChatBot'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
      ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatBotScreen()));
              break;
            case 1:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CalendarScreen()));
              break;
            case 2:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage()));
              break;
            case 3:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
              break;
            case 4:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
              break;
          }
        }

    );
  }
}
