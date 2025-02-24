import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_bot/Screens/utilits/AddAppoinmetToFirestore.dart';
import 'package:medi_bot/Screens/utilits/SelectedDateController.dart';

class Addappointment extends StatefulWidget {
  const Addappointment({super.key});

  @override
  State<Addappointment> createState() => _AddappointmentState();
}

class _AddappointmentState extends State<Addappointment> {
   String? selectedDoctor;
  TextEditingController dateTimeController = TextEditingController();
  final List<String> doctors = ['Yousef', 'Gehad', 'Karim Magdy'];
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Appointment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF366AA6),
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Fill out the fields and hit the Save \nButton to add it!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Doctor Field
            const Text(
              "Doctor",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.grey.shade400),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonFormField<String>(
                value: selectedDoctor,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                hint: const Text("Select Doctor"),
                icon: const Icon(Icons.arrow_drop_down),
                items: doctors.map((doctor) {
                  return DropdownMenuItem(
                    value: doctor,
                    child: Text(doctor),
                  );
                }).toList(),
                onChanged: (value) => setState(() => selectedDoctor = value),
              ),
            ),
            const SizedBox(height: 10),

            // Reminders Section

            const SizedBox(height: 15),

            const Text(
              "Date",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => selectDateTime(context, dateTimeController),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.grey.shade400),
                ),
                height: 55,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: dateTimeController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month, color: Colors.grey),
                      border: InputBorder.none,
                      hintText: "dd/mm/yyyy , 00:00",
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Turn on Alarm",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Switch(
                    value: isOn,
                    activeColor: const Color(0xFF366AA6),
                    onChanged: (value) => setState(() => isOn = value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: _saveAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF366AA6),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );

  }
  void _saveAppointment() {
    if (selectedDoctor == null ||
        isOn == null ||
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
      final addAppointmentToFirestore = AddAppoinmetToFirestore(email: FirebaseAuth.instance.currentUser!.email!,selectedDoctor:selectedDoctor,isOn: isOn, dateTimeController: dateTimeController );
      addAppointmentToFirestore.addAppointmentToDatabase();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Appointment added successfully'),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {
        selectedDoctor = null;
        dateTimeController.clear();
        isOn=false;
      });

    }
  }


}
