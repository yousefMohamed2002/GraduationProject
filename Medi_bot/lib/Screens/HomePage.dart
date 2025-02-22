// Karim Gui And Yousef Firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_bot/Screens/AddMedication.dart';
import 'package:medi_bot/Screens/Blood.dart';
import 'package:medi_bot/Screens/Heart.dart';
import 'package:medi_bot/Screens/Prescription.dart';
import '../Bottom_Bar/custom_bottom_nav_bar.dart'; // Ensure this import is correct

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
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(
            "Hello !!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            userName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: "Search medicines",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            /// Appointments & Doctor Section
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _navigateToAppointments,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('images/Appointment_png_flutter.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: _navigateToDoctor,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
            SizedBox(height: 20),

            /// Actions Section
            Text("Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAction(context, Icons.favorite, "Heart", _navigateToHeart),
                _buildAction(context, Icons.medication, "Medicine", _navigateToMedicine),
                _buildAction(context, Icons.bloodtype, "Blood", _navigateToBlood),
                _buildAction(context, Icons.receipt, "Prescription", _navigateToPrescription),
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

  /// Reusable widget for actions with custom onTap function
  Widget _buildAction(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey[200],
            ),
            child: Icon(icon, size: 30, color: Colors.black),
          ),
          SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  /// 🫀 Heart Screen Navigation
  void _navigateToHeart() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Heart(),));
  }

  /// 💊 Medicine Screen Navigation
  void _navigateToMedicine() {
    Navigator.push(context, MaterialPageRoute(builder:(context) => AddMedication()));
  }

  /// 🩸 Blood Screen Navigation
  void _navigateToBlood() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Blood(),));
  }

  /// 📝 Prescription Screen Navigation
  void _navigateToPrescription() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Prescription()));
  }

  /// 📅 Appointments Navigation
  void _navigateToAppointments() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text("Appointments")),
        body: Center(child: Text("Appointments Screen", style: TextStyle(fontSize: 24))),
      );
    }));
  }

  /// 🩺 Doctor Navigation
  void _navigateToDoctor() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text("Doctor")),
        body: Center(child: Text("Doctor Screen", style: TextStyle(fontSize: 24))),
      );
    }));
  }
}
