import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import '../controller/banner_image_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Define the _selectedIndex variable
  final BannerImageController controller = Get.put(BannerImageController());

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Black background color
      appBar: AppBar(
        title: Text(
          'Ride Wave',
          style: GoogleFonts.poppins(
            fontSize: 24.sp,
            color: Colors.white, // White text color for visibility
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: AppDrawer(), // Use AppDrawer
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar Section
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: 'Where to?',
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.grey[800], // Dark gray for search bar background
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Now',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Categories Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategoryCard('Trip'),
                _buildCategoryCard('Intercity'),
                _buildCategoryCard('Reserve'),
                _buildCategoryCard('Rentals'),
              ],
            ),
            SizedBox(height: 20.h),

            // Banner Section
            Obx(() {
              if (controller.bannerimages.isEmpty) {
                return Center(
                  child: Text(
                    'No banners found',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                );
              }
              return CarouselSlider(
                options: CarouselOptions(
                  height: 150.h,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                ),
                items: controller.bannerimages.map((banner) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.network(
                            banner.image_url,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 150.h,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            }),
            SizedBox(height: 20.h),

            // Ride Options Section
            Text(
              'Ride as you like it',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildRideOptionCard('Book Auto', 'Everyday commute made effortless'),
                _buildRideOptionCard('Book XL', 'Travel with luggage and friends'),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900], // Darker background for BottomNavigationBar
        items: [
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
        currentIndex: _selectedIndex, // Set the selected index
        onTap: _onItemTapped, // Handle item tap
      ),
    );
  }

  // Helper method for category cards
  Widget _buildCategoryCard(String title) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.grey[800], // Darker background for category cards
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        title,
        style: GoogleFonts.poppins(color: Colors.white),
      ),
    );
  }

  // Helper method for ride option cards
  Widget _buildRideOptionCard(String title, String subtitle) {
    return Container(
      width: 150.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.grey[800], // Darker background for ride option cards
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: Colors.white70,
            ),
          ),
        ],
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
      DocumentSnapshot userDoc =
      await _firestore.collection('user_data').doc(user.uid).get();
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
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.white)));
          } else {
            String accountName = snapshot.data?['name'] ?? 'No Name';
            String accountEmail = snapshot.data?['email'] ?? 'No Email';

            return Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName:
                  Text(accountName, style: TextStyle(color: Colors.white)),
                  accountEmail: Text(accountEmail,
                      style: TextStyle(color: Colors.white54)),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white54,
                    backgroundImage:
                    AssetImage('assets/images/Billy butcher pfp.jpeg'),
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
                        title: Text('Profile',
                            style: TextStyle(color: Colors.white54)),
                        onTap: () {
                          // Navigate to Profile
                        },
                      ),
                      ListTile(
                        leading:
                        Icon(Icons.directions_car, color: Colors.white54),
                        title: Text('Live Trip',
                            style: TextStyle(color: Colors.white54)),
                        onTap: () {
                          // Navigate to Live Trip
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.history, color: Colors.white54),
                        title: Text('Trip History',
                            style: TextStyle(color: Colors.white54)),
                        onTap: () {
                          // Navigate to Trip History
                        },
                      ),
                      Divider(color: Colors.white30),
                      ListTile(
                        leading: Icon(Icons.lock, color: Colors.white54),
                        title: Text('Privacy Policy',
                            style: TextStyle(color: Colors.white54)),
                        onTap: () {
                          // Navigate to Privacy Policy
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.description, color: Colors.white54),
                        title: Text('Terms and Conditions',
                            style: TextStyle(color: Colors.white54)),
                        onTap: () {
                          // Navigate to Terms and Conditions
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.cancel, color: Colors.white54),
                        title: Text('Cancellation',
                            style: TextStyle(color: Colors.white54)),
                        onTap: () {
                          // Navigate to Cancellation
                        },
                      ),
                      ListTile(
                        leading:
                        Icon(Icons.contact_phone, color: Colors.white54),
                        title: Text('Contact Us',
                            style: TextStyle(color: Colors.white54)),
                        onTap: () {
                          // Navigate to Contact Us
                        },
                      ),
                      Divider(color: Colors.white30),
                      ListTile(
                        leading: Icon(Icons.logout, color: Colors.white54),
                        title: Text('Logout',
                            style: TextStyle(color: Colors.white54)),
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
