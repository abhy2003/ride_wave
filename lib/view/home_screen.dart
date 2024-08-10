import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../controller/banner_image_controller.dart';
import 'package:ride_wave/controller/banner_image_controller.dart'; // Import your BannerImageController

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                aspectRatio: 16/9,
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
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Drawer(
        backgroundColor: Colors.black,
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
            SizedBox(),
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
    );
  }
}
