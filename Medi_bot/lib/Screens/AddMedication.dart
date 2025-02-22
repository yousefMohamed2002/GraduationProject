import 'package:flutter/material.dart';

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
  TextEditingController dateController = TextEditingController();

  final List<String> medicines = ['Vitamin D', 'Vitamin C', 'Paracetamol'];
  final List<String> types = ['Tablet', 'Capsule', 'Liquid'];
  final List<String> doses = ['500mg', '1000mg', '1500mg'];
  final List<String> amounts = ['1', '2', '3', '4'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Widget buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label* ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(width: 1.5, color: const Color(0xFF196EB0)),
          ),
          width: 400,
          height: 70,
          child: DropdownButtonFormField<String>(
            value: value,
            onChanged: onChanged,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

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
                  "Date* ",
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
              onTap: () => _selectDate(context),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.5, color: const Color(0xFF196EB0)),
                ),
                width: 400,
                height: 70,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Select Date",
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Save logic here
              },
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
}
