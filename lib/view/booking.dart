import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = 'your_user_id'; // Replace with the actual user ID

  // Controllers for text fields
  final TextEditingController _pickUpController = TextEditingController();
  final TextEditingController _dropOffController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // Global key for form validation
  final _formKey = GlobalKey<FormState>();

  bool _isTopSheetVisible = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch user data from Firestore
  void _fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        setState(() {
          _nameController.text = userDoc.get('name') ?? 'No Name'; // Fetch 'name' field from document
        });
      } else {
        print('User document does not exist');
      }
    } catch (e) {
      // Handle errors
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background map image
          Positioned.fill(
            child: Image.asset(
              'assets/images/map_image.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          // ListView to hold content
          Positioned.fill(
            child: ListView(
              children: [
                SizedBox(height: 16.h), // Add space if needed

                // Button to open booking form
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: ElevatedButton(
                    onPressed: () => _toggleTopSheet(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Text(
                        'Open Booking',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Custom top sheet
          if (_isTopSheetVisible)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Add space at the top for better readability
                    SizedBox(height: 24.h),

                    // User profile and car image at the top
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24.r,
                          backgroundImage: AssetImage('assets/images/Billy butcher pfp.jpeg'),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Enter name',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                color: Colors.white70,
                              ),
                              border: InputBorder.none,
                            ),
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Spacer(),
                        Image.asset(
                          'assets/images/lamorgini.png',
                          width: 60.w,
                          height: 30.h,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    // Form for input fields
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _locationField(
                            icon: Icons.radio_button_checked,
                            label: 'Pick-up Location',
                            controller: _pickUpController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter pick-up location';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8.h),
                          _locationField(
                            icon: Icons.location_on,
                            label: 'Drop-off Location',
                            controller: _dropOffController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter drop-off location';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          // Button to confirm the booking
                          ElevatedButton(
                            onPressed: _confirmBooking,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFC5FF39),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Text(
                                'Confirm Booking',
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h), // Add some space at the bottom
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Toggle the visibility of the top sheet
  void _toggleTopSheet() {
    setState(() {
      _isTopSheetVisible = !_isTopSheetVisible;
    });
  }

  // Confirm booking and handle navigation
  void _confirmBooking() {
    if (_formKey.currentState?.validate() ?? false) {
      // Navigate to the next page if the form is valid
      Get.toNamed('/nextPage');
    }
  }

  // Widget to create a location input field
  Widget _locationField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      hintText: label,
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 14.sp,
                      ),
                    ),
                    style: GoogleFonts.poppins(color: Colors.white),
                    validator: validator,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
