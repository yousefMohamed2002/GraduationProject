//Yousef Mohamed
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatelessWidget {
  final String email;
  final String userName;


  const AddUser(this.email, this.userName, {Key? key}) : super(key: key);

  // Method to add user to Firestore
  Future<void> addUser() {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return users.add({
      'Email': email,
      'UserName': userName,
    }).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
