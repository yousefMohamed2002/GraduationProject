import 'package:flutter/material.dart';
import 'package:medi_bot/auth/SignIn.dart';

class CheckMailPage extends StatefulWidget {
  const CheckMailPage({super.key});

  @override
  _CheckMailPageState createState() => _CheckMailPageState();
}

class _CheckMailPageState extends State<CheckMailPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: const CircleAvatar(
                backgroundImage: AssetImage("images/cheackmail.png"),
              ),
            ),
            const SizedBox(height: 20), // Add some space between the image and text
            const Text(
              "📬\nCheck Your Inbox!\nWe’ve sent you an email to reset your password.\nJust click the link inside and you’ll be back on track!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
