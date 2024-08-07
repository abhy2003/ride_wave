import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taxi Booking App'),
        backgroundColor: Color(0xFFC5FF39),
      ),
      drawer: AppDrawer(),
      body: Scaffold(
        backgroundColor: Colors.black,
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person, color: Colors.white54),
            title: Text('Profile',
                style:
                TextStyle(color: Colors.white54)),
            onTap: () {
              // Navigate to Profile
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_car,
                color: Colors.white54),
            title: Text('Live Trip',
                style:
                TextStyle(color: Colors.white54)),
            onTap: () {
              // Navigate to Live Trip
            },
          ),
          ListTile(
            leading: Icon(Icons.history, color: Colors.white54),
            title: Text('Trip History',
                style:
                TextStyle(color: Colors.white54)),
            onTap: () {
              // Navigate to Trip History
            },
          ),
          SizedBox(),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.white54),
            title: Text('Privacy Policy',
                style:
                TextStyle(color: Colors.white54)),
            onTap: () {
              // Navigate to Privacy Policy
            },
          ),
          ListTile(
            leading:
            Icon(Icons.description, color: Colors.white54),
            title: Text('Terms and Conditions',
                style:
                TextStyle(color: Colors.white54)),
            onTap: () {
              // Navigate to Terms and Conditions
            },
          ),
          ListTile(
            leading: Icon(Icons.cancel, color: Colors.white54),
            title: Text('Cancellation',
                style:
                TextStyle(color: Colors.white54)),
            onTap: () {
              // Navigate to Cancellation
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_phone,
                color: Colors.white54),
            title: Text('Contact Us',
                style:
                TextStyle(color: Colors.white54)),
            onTap: () {
              // Navigate to Contact Us
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.white54),
            title: Text('Logout',
                style:
                TextStyle(color: Colors.white54)),
            onTap: () {
              // Handle Logout
            },
          ),
        ],
      ),
    );
  }
}
