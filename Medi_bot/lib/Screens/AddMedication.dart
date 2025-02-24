import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_bot/Screens/utilits/AddMedicationsToFireatore.dart';
import 'package:medi_bot/Screens/utilits/BuildDropDownList.dart';
import 'package:medi_bot/Screens/utilits/SelectedDateController.dart';



class AddMedication extends StatefulWidget {
  const AddMedication({super.key});

  @override
  State<AddMedication> createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  String? selectedMedicine;
  String? selectedType;
  String? selectedDose;
  String? selectedAmount;
  bool isOn=false;
  TextEditingController dateTimeController = TextEditingController();

  final List<String> medicines = ['Vitamin D', 'Vitamin C', 'Paracetamol'];
  final List<String> types = ['Tablet', 'Capsule', 'Liquid'];
  final List<String> doses = ['500mg', '1000mg', '1500mg'];
  final List<String> amounts = ['1', '2', '3', '4'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Medication',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF366AA6),
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Fill out the fields and hit the Save \nButton to add it!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 30),
            buildDropdown(
              label: "Medical Name",
              value: selectedMedicine,
              items: medicines,
              onChanged: (value) => setState(() => selectedMedicine = value),
            ),
            buildDropdown(
              label: "Type",
              value: selectedType,
              items: types,
              onChanged: (value) => setState(() => selectedType = value),
            ),
            buildDropdown(
              label: "Dose",
              value: selectedDose,
              items: doses,
              onChanged: (value) => setState(() => selectedDose = value),
            ),
            buildDropdown(
              label: "Amount",
              value: selectedAmount,
              items: amounts,
              onChanged: (value) => setState(() => selectedAmount = value),
            ),
            Row(
              children: const [
                Text(
                  "Reminders",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Text(
                  "Date & Time* ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => selectDateTime(context,dateTimeController),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.5, color: const Color(0xFF196EB0)),
                ),
                width: 400,
                height: 70,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: dateTimeController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Select Date & Time",
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black12),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Turn On Alarm",style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),)
                  ,Switch(
                    value: isOn,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {
                        isOn = value;
                        // Handle dark mode toggle logic
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: _saveMedication,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF196EB0)),
                minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  void _saveMedication() {
    if (selectedMedicine == null ||
        selectedType == null ||
        selectedDose == null ||
        selectedAmount == null ||
        dateTimeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    else{
      final addMedicationsToFirestore = AddMedicationsToFirestore(email: FirebaseAuth.instance.currentUser!.email!, selectedMedicine: selectedMedicine!, selectedType: selectedType!, selectedDose: selectedDose!, selectedAmount: selectedAmount!, dateTimeController: dateTimeController, isOn: isOn,);
      addMedicationsToFirestore.addMedicationsToDatabase();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Medication added successfully'),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {
        selectedMedicine = null;
        selectedType = null;
        selectedDose = null;
        selectedAmount = null;
        dateTimeController.clear();
        isOn=false;
      });

    }


  }
}
