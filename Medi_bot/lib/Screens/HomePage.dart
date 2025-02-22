import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Bottom_Bar/custom_bottom_nav_bar.dart'; // Ensure this import is correct

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  CollectionReference usersref = FirebaseFirestore.instance.collection("Users");
  List users = [];
  String userName = "Loading ....";
  bool isLoading = true; // Added loading state
  String errorMessage = ''; // Added error message state

  @override
  void initState() {
    super.initState();
    getDocumentId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(
            "Hello !!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            userName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 25,
            ),
          ),
        ),
      ),


      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2), // Added bottom navigation bar
    );
  }

  void getDocumentId() async {
    String? email = FirebaseAuth.instance.currentUser?.email;

    try {
      var respondBody = await usersref.get();

      setState(() {
        users = respondBody.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        isLoading = false; // Data loaded, stop loading
      });

      for (var user in users) {
        if (user['Email'] == email) {
          setState(() {
            userName = user["UserName"] ?? "No Name Found";
            print("UserName: $userName");
          });
          break; // Stop the loop once user is found
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading on error
        errorMessage = 'Error fetching data: $e'; // Set error message
      });
      print("Error: $e");
    }
  }
}