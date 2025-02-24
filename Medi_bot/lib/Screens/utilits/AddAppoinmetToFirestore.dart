import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AddAppoinmetToFirestore {
  final String? email;
  final String? selectedDoctor;
  final TextEditingController dateTimeController;
  bool isOn;

  AddAppoinmetToFirestore({
    required this.email,
    required this.selectedDoctor,
    required this.dateTimeController,
    required this.isOn
  });

  // Method to add medication to Firestore
  Future<bool> addMedicationsToDatabase() async {
    if (dateTimeController.text.isEmpty) {
      print("DateTime is empty");
      return false;
    }

    try {
      // Validate DateTime format
      final dateTime = DateTime.parse(dateTimeController.text);

      CollectionReference medications =
      FirebaseFirestore.instance.collection('Appointment');
      await medications.add({
        'Email': email,
        'Doctor': selectedDoctor,
        'dateTime': Timestamp.fromDate(dateTime),
        'Alarm':isOn
      });
      print("Appointment Added");
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