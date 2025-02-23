// Yousef Yasser
import 'package:flutter/material.dart';

import '../auth/SignIn.dart';

class PasswordChangedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 80, color: Colors.green),
              SizedBox(height: 20),
              Text("Password Changed!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.blue)),
              SizedBox(height: 10),
              Text("Your password has been changed successfully.", textAlign: TextAlign.center),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                },
                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50),backgroundColor: Colors.blue[900],shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),),
                child: Text("Back to Login",style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
