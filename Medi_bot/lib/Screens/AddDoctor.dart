import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_bot/Screens/utilits/AddDoctorToFirbase.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({super.key});

  @override
  State<AddDoctor> createState() => _AddDoctor();
}

class _AddDoctor extends State<AddDoctor> {
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  String? selectedType;
  final List<String> types = ['Dermatologist', 'Cardiologist', 'General Practitioner'];

  @override
  void dispose() {
    doctorNameController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Widget _buildLabeledField(String label, Widget field) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          field,
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fieldWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Add Doctor',
          style:TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF366AA6),
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Fill out the fields and hit the Save \n button to add the doctor.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Doctor Name Field
            _buildLabeledField(
              "Name",
              SizedBox(
                width: fieldWidth,
                height: 50,
                child: TextFormField(

                  controller: doctorNameController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter doctor name',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF366AA6)),
                    ),
                  ),
                ),
              ),
            ),

            // Type Dropdown
            _buildLabeledField(
              "Type",
              SizedBox(
                width: fieldWidth,
                height: 50,
                child: DropdownButtonFormField<String>(
                  value: selectedType,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Select doctor type",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF366AA6)),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  items: types.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                  onChanged: (value) => setState(() => selectedType = value),
                ),
              ),
            ),

            // Notes Field
            _buildLabeledField(
              "Notes",
              SizedBox(
                width: fieldWidth,
                height: 200,
                child: TextField(
                  controller: noteController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Enter additional notes (optional)',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFF366AA6)),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: fieldWidth * 0.6,
              child: ElevatedButton(
                onPressed: _saveDoctor,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF196EB0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveDoctor() {
    if (doctorNameController.text.trim().isEmpty || selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final addDoctorToFirestore = AddDoctorToFirestore(
      email: FirebaseAuth.instance.currentUser!.email!,
      selectedDoctor: doctorNameController.text.trim(),
      Type: selectedType,
      Note: noteController.text.trim(),
    );

    addDoctorToFirestore.addDoctorToDatabase();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Doctor added successfully'),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      doctorNameController.clear();
      noteController.clear();
      selectedType = null;
    });
  }
}