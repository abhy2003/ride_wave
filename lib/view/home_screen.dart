import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../controller/banner_image_controller.dart';
import 'package:ride_wave/controller/banner_image_controller.dart'; // Import your BannerImageController

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Track the selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final BannerImageController controller = Get.find<BannerImageController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Taxi Booking App'),
        backgroundColor: Color(0xFFC5FF39),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Obx(() {
            if (controller.bannerimages.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
              ),
              items: controller.bannerimages.map((banner) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                      ),
                      child: Image.network(banner.image_url, fit: BoxFit.cover),
                    );
                  },
                );
              }).toList(),
            );
          }),
          Expanded(
            child: Container(
              color: Colors.black,
              child: Center(
                child: Text(
                  'Welcome to the Taxi Booking App!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF000000), // Background color of the BottomNavigationBar
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? ImageIcon(AssetImage('assets/icons/bottom_navigation/home_icon.png'))
                  : ImageIcon(AssetImage('assets/icons/bottom_navigation/home_icon.png')),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? ImageIcon(AssetImage('assets/icons/bottom_navigation/search_icon.png'))
                  : ImageIcon(AssetImage('assets/icons/bottom_navigation/search_icon.png')),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? ImageIcon(AssetImage('assets/icons/bottom_navigation/service_icon.png'))
                  : ImageIcon(AssetImage('assets/icons/bottom_navigation/service_icon.png')),
              label: 'Service',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white, // Color of the selected item
          unselectedItemColor: Colors.white70, // Color of unselected items
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent, // Makes the BottomNavigationBar transparent to show the container color
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: <Widget>[
          // Header Section
          UserAccountsDrawerHeader(
            accountName: Text('Sandeep K', style: TextStyle(color: Colors.white)),
            accountEmail: Text('Sanddeepkrishnan42@gmail.com',
                style: TextStyle(color: Colors.white54)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white54,
              backgroundImage: AssetImage('assets/images/Billy butcher pfp.jpeg'), // Use the asset image here
              radius: 30, // Adjust radius if needed
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          // List Section
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.person, color: Colors.white54),
                  title: Text('Profile', style: TextStyle(color: Colors.white54)),
                  onTap: () {
                    // Navigate to Profile
                  },
                ),
                ListTile(
                  leading: Icon(Icons.directions_car, color: Colors.white54),
                  title: Text('Live Trip', style: TextStyle(color: Colors.white54)),
                  onTap: () {
                    // Navigate to Live Trip
                  },
                ),
                ListTile(
                  leading: Icon(Icons.history, color: Colors.white54),
                  title: Text('Trip History', style: TextStyle(color: Colors.white54)),
                  onTap: () {
                    // Navigate to Trip History
                  },
                ),
                Divider(color: Colors.white30),
                ListTile(
                  leading: Icon(Icons.lock, color: Colors.white54),
                  title: Text('Privacy Policy', style: TextStyle(color: Colors.white54)),
                  onTap: () {
                    // Navigate to Privacy Policy
                  },
                ),
                ListTile(
                  leading: Icon(Icons.description, color: Colors.white54),
                  title: Text('Terms and Conditions', style: TextStyle(color: Colors.white54)),
                  onTap: () {
                    // Navigate to Terms and Conditions
                  },
                ),
                ListTile(
                  leading: Icon(Icons.cancel, color: Colors.white54),
                  title: Text('Cancellation', style: TextStyle(color: Colors.white54)),
                  onTap: () {
                    // Navigate to Cancellation
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contact_phone, color: Colors.white54),
                  title: Text('Contact Us', style: TextStyle(color: Colors.white54)),
                  onTap: () {
                    // Navigate to Contact Us
                  },
                ),
                Divider(color: Colors.white30),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.white54),
                  title: Text('Logout', style: TextStyle(color: Colors.white54)),
                  onTap: () {
                    // Handle Logout
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
