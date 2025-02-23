// Karim Gui And Yousef Firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:medi_bot/Screens/AddMedication.dart';
import 'package:medi_bot/Screens/Blood.dart';
import 'package:medi_bot/Screens/Heart.dart';
import 'package:medi_bot/Screens/Prescription.dart';
import 'package:medi_bot/Screens/utilits/Bottom_Bar/custom_bottom_nav_bar.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  CollectionReference usersref = FirebaseFirestore.instance.collection("Users");
  List users = [];
  String userName = "Loading ....";
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    getDocumentId();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
        title: ListTile(
          title: Text(
            "Hello !!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: size.width * 0.05,
            ),
          ),
          subtitle: Text(
            userName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: size.width * 0.06,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),
            TextField(
              decoration: InputDecoration(
                hintText: "Search medicines",
                prefixIcon: Icon(Icons.search, size: size.width * 0.06),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(size.width * 0.03),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),

            /// Appointments & Doctor Section
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _navigateToAppointments,
                    child: Container(
                      height: size.height * 0.18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.width * 0.03),
                        image: DecorationImage(
                          image: AssetImage('images/Appointment_png_flutter.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.03),
                Expanded(
                  child: GestureDetector(
                    onTap: _navigateToDoctor,
                    child: Container(
                      height: size.height * 0.18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.width * 0.03),
                        image: DecorationImage(
                          image: AssetImage('images/doctor_png_flutter.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),

            /// Actions Section
            Text(
              "Actions",
              style: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAction(context, Icons.favorite, "Heart", _navigateToHeart, size),
                _buildAction(context, Icons.medication, "Medicine", _navigateToMedicine, size),
                _buildAction(context, Icons.bloodtype, "Blood", _navigateToBlood, size),
                _buildAction(context, Icons.receipt, "Prescription", _navigateToPrescription, size),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2),
    );
  }

  void getDocumentId() async {
    String? email = FirebaseAuth.instance.currentUser?.email;

    try {
      var respondBody = await usersref.get();

      setState(() {
        users = respondBody.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        isLoading = false;
      });

      for (var user in users) {
        if (user['Email'] == email) {
          setState(() {
            userName = user["UserName"] ?? "No Name Found";
          });
          break;
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching data: $e';
      });
      print("Error: $e");
    }
  }

  /// Reusable widget for actions with responsive design
  Widget _buildAction(BuildContext context, IconData icon, String label, VoidCallback onTap, Size size) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(size.width * 0.04),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(size.width * 0.02),
            ),
            child: Icon(icon, size: size.width * 0.07, color: Colors.black),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            label,
            style: TextStyle(fontSize: size.width * 0.03),
          ),
        ],
      ),
    );
  }

  void _navigateToHeart() => Navigator.push(context, MaterialPageRoute(builder: (context) => Heart()));
  void _navigateToMedicine() => Navigator.push(context, MaterialPageRoute(builder: (context) => AddMedication()));
  void _navigateToBlood() => Navigator.push(context, MaterialPageRoute(builder: (context) => Blood()));
  void _navigateToPrescription() => Navigator.push(context, MaterialPageRoute(builder: (context) => Prescription()));

  void _navigateToAppointments() => Navigator.push(context, MaterialPageRoute(builder: (_) => Scaffold(
    appBar: AppBar(title: Text("Appointments")),
    body: Center(child: Text("Appointments Screen", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05))),
  )));

  void _navigateToDoctor() => Navigator.push(context, MaterialPageRoute(builder: (_) => Scaffold(
    appBar: AppBar(title: Text("Doctor")),
    body: Center(child: Text("Doctor Screen", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05))),
  )));
}
