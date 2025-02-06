# Ride Wave

Ride Wave is an Uber-like online taxi booking application built using Flutter and Firebase. The app allows users to book rides, track their drivers in real-time, and make secure payments. Drivers can accept trip requests and navigate to the pickup and drop-off locations efficiently.

## Features

### User Features
- **OTP Authentication**: Secure login via Firebase Authentication.
- **Ride Booking**: Users can book rides by selecting pickup and drop-off locations.
- **Real-Time Tracking**: View the driver’s location on Google Maps.
- **Fare Estimation**: Get an estimated fare based on distance before confirming the trip.
- **Trip History**: View past trip details.
- **Notifications**: Get notified when a driver accepts a ride and reaches the pickup point.
- **Custom UI**: A sleek, user-friendly interface built with Flutter and GetX.

### Driver Features
- **Trip Requests**: Accept or reject ride requests.
- **Navigation Support**: Integrated Google Maps for turn-by-turn navigation.
- **Earnings Dashboard**: Track daily earnings and completed trips.

## Tech Stack
- **Flutter**: Frontend framework for cross-platform development.
- **Firebase**:
  - Authentication (OTP verification)
  - Firestore (User, Driver, and Trip data storage)
  - Cloud Messaging (Push notifications)
- **Google Maps API**:
  - Location tracking
  - Distance and route calculation

## Installation

1. **Clone the repository**
   ```sh
   git clone https://github.com/yourusername/ridewave.git
   cd ridewave
   ```

2. **Install dependencies**
   ```sh
   flutter pub get
   ```

3. **Set up Firebase**
   - Add your Firebase project.
   - Download the `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) and place them in the appropriate directories.

4. **Run the application**
   ```sh
   flutter run
   ```

## Future Enhancements
- **Payment Integration** (Razorpay/Stripe)
- **Ride Sharing** (Pool rides)
- **Advanced Driver Analytics**

## Contributing
Feel free to submit pull requests or report issues in the repository.

## Contact
For any queries, reach out to me at **bijuabhishek530@gmail.com**.

---


