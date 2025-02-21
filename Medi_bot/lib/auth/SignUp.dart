import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medi_bot/auth/AddUser.dart';

import 'SignIn.dart';

void main() {
  runApp(const SignUpPage());
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  String? email;
  String? username;
  String? password;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void showSnackBar(BuildContext context, String message, {Color color = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(32, 33, 100, 1),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "For Free",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.05),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                  vertical: size.height * 0.04,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        onSaved: (value) => email = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextFormField(
                        onSaved: (value) => username = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: size.height * 0.02),
                      TextFormField(
                        onSaved: (value) => password = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a password";
                          } else if (value.length < 8) {
                            return "Password must be at least 8 characters";
                          } else if (!RegExp(r'(?=.*[0-9])').hasMatch(value)) {
                            return "Password must contain at least one number";
                          } else if (!RegExp(r'(?=.*[!@#\$%^&*])').hasMatch(value)) {
                            return "Password must contain at least one special character (!@#\$%^&*)";
                          }
                          return null;
                        },
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black54,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            String? errorMessage = await createUserWithEmailAndPassword(email!, password!);

                            if (errorMessage == null) {
                              showSnackBar(context, "Account created successfully!", color: Colors.green);
                                AddUser(email!, username!, password!).addUser();
                                showSnackBar(context, "Account created successfully!", color: Colors.green);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );

                            } else {
                              showSnackBar(context, errorMessage);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(54, 106, 166, 1),
                          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                color: Color.fromRGBO(54, 106, 166, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<String?> createUserWithEmailAndPassword(String emailAddress, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    return null; // Success
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    } else if (e.code == 'invalid-email') {
      return 'The email address is not valid.';
    } else {
      return 'An error occurred. Please try again.';
    }
  } catch (e) {
    return 'Unexpected error: $e';
  }
}

