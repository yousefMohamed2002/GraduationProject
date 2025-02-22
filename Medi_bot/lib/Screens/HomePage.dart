import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  CollectionReference usersref = FirebaseFirestore.instance.collection("Users");
  List users = [];
  String userName = "Loading ....";

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
              fontSize: 25
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              
            ],
          )
        ],
      ),
    );
  }

  void getDocumentId() async {
    String? email = FirebaseAuth.instance.currentUser?.email;

    try {
      var respondBody = await usersref.get();

      setState(() {
        users = respondBody.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
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
        userName = 'Error fetching data';
      });
      print("Error: $e");
    }
  }
}
