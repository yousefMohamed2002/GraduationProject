import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AddMedicationsToFirestore {
  final String email;
  final String selectedMedicine;
  final String selectedType;
  final String selectedDose;
  final String selectedAmount;
  final TextEditingController dateTimeController;

  AddMedicationsToFirestore({
    required this.email,
    required this.selectedMedicine,
    required this.selectedType,
    required this.selectedDose,
    required this.selectedAmount,
    required this.dateTimeController,
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
      FirebaseFirestore.instance.collection('Medications');
      await medications.add({
        'Email': email,
        'medicine': selectedMedicine,
        'type': selectedType,
        'dose': selectedDose,
        'amount': selectedAmount,
        'dateTime': Timestamp.fromDate(dateTime),
      });
      print("Medication Added");
      return true; // Success
    } on FormatException {
      print("Invalid DateTime format");
      return false;
    } catch (error) {
      print("Failed to add medication: $error");
      return false;
    }
  }
}