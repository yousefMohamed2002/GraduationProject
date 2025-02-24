import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AddDoctorToFirestore {
  final String? email;
  final String? selectedDoctor;
  final String? Type;
  final String? Note;




  AddDoctorToFirestore({
    required this.email,
    required this.selectedDoctor,
    required this.Type,
    required this.Note,
  });

  // Method to add medication to Firestore
  Future<bool> addDoctorToDatabase() async {

    try {
      // Validate DateTime format


      CollectionReference medications =
      FirebaseFirestore.instance.collection('Doctors');
      await medications.add({
        'Email': email,
        'Doctor': selectedDoctor,
        'Type': Type,
        'Note':Note,
      });
      print("Doctor Added");
      return true; // Success
    } on FormatException {
      print("Invalid DateTime format");
      return false;
    } catch (error) {
      print("Failed to add Appointment: $error");
      return false;
    }
  }
}