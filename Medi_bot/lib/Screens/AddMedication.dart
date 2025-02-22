import 'package:flutter/material.dart';

class AddMedication extends StatefulWidget {
  const AddMedication({super.key});

  @override
  State<AddMedication> createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  String? selectedMedicine;
  String? selectedDose;
  TextEditingController dateController = TextEditingController();

  final List<String> medicines = ['Vitamin D', 'Vitamin C', 'Paracetamol'];
  final List<String> doses = ['500mg', '1000mg', '1500mg'];

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Expanded(
            child: Row(
              
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
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
            ],
                    ),
          ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
          Row(
          children: [
          Text(
          "Medical Name* ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              width: 1.5,
              color: Color(0xFF196EB0),
            ),
          ),
          width: 400,
          height: 70,
          child: DropdownButtonFormField<String>(
            value: selectedMedicine,
            onChanged: (String? newValue) {
              setState(() {
                selectedMedicine = newValue;
              });
            },
            items: medicines.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Text(
              "Type* ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        // Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(15),
        //     border: Border.all(
        //       width: 1.5,
        //       color: Color(0xFF196EB0),
        //     )),
        //     width: 400,
        //     height: 70,
        //     child: TextFormField(),
        //   ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 1.5,
                    color: Color(0xFF196EB0),
                  ),
                ),
                width: 400,
                height: 70,
                child: DropdownButtonFormField<String>(
                  value: selectedDose,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDose = newValue;
                    });
                  },
                  items: doses.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                "Dose* ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 1.5,
                color: Color(0xFF196EB0),
              ),
            ),
            width: 400,
            height: 70,
            child: DropdownButtonFormField<String>(
              value: selectedDose,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDose = newValue;
                });
              },
              items: doses.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                "Amount* ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 1.5,
                    color: Color(0xFF196EB0),
                  ),
                ),
                width: 400,
                height: 70,
                child: DropdownButtonFormField<String>(
                  value: selectedDose,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDose = newValue;
                    });
                  },
                  items: doses.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              // Container(
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     border: Border.all(
          //       width: 1.5,
          //       color: Color(0xFF196EB0),
          //     ),
          //   ),
          //   width: 400,
          //   height: 70,
          //   child: TextFormField(),
          // ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                "Reminders ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
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
          SizedBox(height: 10),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1.5,
                  color: Color(0xFF196EB0),
                ),
              ),
              width: 400,
              height: 70,
              child: AbsorbPointer(
                child: TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.calendar_month),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: "Select Date",
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Save logic here
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF196EB0)),
              minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)), // Set minimum width and height
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),

            ),
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ]),
        ),
      ],
    ),
    ),
    );
  }
}