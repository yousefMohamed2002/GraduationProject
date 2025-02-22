/*import 'package:flutter/material.dart';

import '../Bottom_Bar/custom_bottom_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.language, size: 30),
              title: Text('Language', style: TextStyle(fontSize: 18)),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle language change
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.dark_mode, size: 30),
              title: Text('Darkmode', style: TextStyle(fontSize: 18)),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle dark mode change
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 4),
    );
  }
}
*/
import 'package:flutter/material.dart';
import '../Bottom_Bar/custom_bottom_nav_bar.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            children: [
              _buildSettingsItem(
                icon: Icons.language,
                title: 'Language',
                onTap: () {
                  // Handle language change
                },
              ),
              _buildDivider(),
              _buildDarkModeSwitch(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 4),
    );
  }

  Widget _buildSettingsItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, size: 30, color: Colors.blue),
      title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildDarkModeSwitch() {
    return ListTile(
      leading: Icon(Icons.dark_mode, size: 30, color: Colors.blue),
      title: Text('Dark Mode', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      trailing: Switch(
        value: isDarkMode,
        activeColor: Colors.blue,
        onChanged: (value) {
          setState(() {
            isDarkMode = value;
            // Handle dark mode toggle logic
          });
        },
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(thickness: 1, color: Colors.grey.shade300),
    );
  }
}
