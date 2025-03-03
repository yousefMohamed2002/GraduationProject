//Yousef Yasser && Youssef Mohamed firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_bot/Screens//splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medi_bot/Screens/AddMedication.dart';
import 'package:medi_bot/Screens/ChatBotScreen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize Flutter first
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Initialize Firebase next
  );
  runApp(const MediBotApp()); // Run the app after Firebase is ready
}

class MediBotApp extends StatelessWidget {
  const MediBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
