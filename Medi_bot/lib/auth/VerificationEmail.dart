import 'package:flutter/material.dart';
import 'package:medi_bot/auth/SignIn.dart';

class VerificationEmail extends StatefulWidget {
  const VerificationEmail({super.key});

  @override
  State<VerificationEmail> createState() => _VerificationEmailState();
}

class _VerificationEmailState extends State<VerificationEmail> {
  bool isEmailSent = false;

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

  void resendEmail() {
    setState(() {
      isEmailSent = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verification email sent!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Your Email')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.email, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 20),
            Center(
              child: const Text(
                'A verification link has been sent to your email. Please check your inbox.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: resendEmail,
              child: const Text('Resend Email'),
            ),
            if (isEmailSent)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Verification email resent!',
                  style: TextStyle(color: Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
