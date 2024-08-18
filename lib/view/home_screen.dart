import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controller/banner_image_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BannerImageController controller = Get.put(BannerImageController());
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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

            return Container(
              color: Colors.black,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 170,
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
              ),
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
        color: const Color(0xFF000000),
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
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, String>> _getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('user_data').doc(user.uid).get();
      String name = userDoc['name'] ?? 'No Name';
      String email = userDoc['email'] ?? 'No Email';
      return {'name': name, 'email': email};
    }
    return {'name': 'No Name', 'email': 'No Email'};
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: FutureBuilder<Map<String, String>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
          } else {
            String accountName = snapshot.data?['name'] ?? 'No Name';
            String accountEmail = snapshot.data?['email'] ?? 'No Email';

            return Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(accountName, style: TextStyle(color: Colors.white)),
                  accountEmail: Text(accountEmail, style: TextStyle(color: Colors.white54)),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white54,
                    backgroundImage: AssetImage('assets/images/Billy butcher pfp.jpeg'),
                    radius: 30,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                ),
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
                          _showLogoutDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Get.back();
                _showLottieAnimationDialog(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showLottieAnimationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/images/lottie/sampl_logout.json',
              ),
              SizedBox(height: 16),
              Text(
                'Logging out...',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
