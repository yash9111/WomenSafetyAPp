// ignore_for_file: file_names

import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_sheet2/sliding_sheet2.dart';
import 'slidingsheet.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _getPermission() async => await [
        Permission.sms,
        Permission.location, // Add location permission
      ].request();

  Future<bool> _isPermissionGranted() async {
    final smsPermissionStatus = await Permission.sms.status.isGranted;
    final locationPermissionStatus = await Permission.location.status.isGranted;
    return smsPermissionStatus && locationPermissionStatus;
  }

  _sendMessageWithLocation(String phoneNumber, String message,
      {int? simSlot}) async {
    if (await _isPermissionGranted()) {
      final currentLocation = await _getCurrentPosition();
      final latitude = currentLocation.latitude;
      final longitude = currentLocation.longitude;
      final messageWithLocation =
          "Help! Latitude: $latitude, Longitude: $longitude\n$message";

      var result = await BackgroundSms.sendMessage(
          phoneNumber: phoneNumber,
          message: messageWithLocation,
          simSlot: simSlot);
      if (result == SmsStatus.sent) {
        print("Sent");
      } else {
        print("Failed");
      }
    } else {
      await _getPermission();
    }
  }

  Position _defaultPosition() {
    return Position(
      latitude: 0.0, // Default latitude
      longitude: 0.0, // Default longitude
      timestamp: DateTime.now(), // Default timestamp (current time)
      accuracy: 0.0, // Default accuracy
      altitude: 0.0, // Default altitude
      heading: 0.0, // Default heading
      speed: 0.0, // Default speed
      speedAccuracy: 0.0, altitudeAccuracy: 0.0,
      headingAccuracy: 0.0, // Default speed accuracy
    );
  }

  Future<Position> _getCurrentPosition() async {
    try {
      final locationPermission = await Permission.location.request();
      if (locationPermission.isGranted) {
        final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        return position;
      } else {
        throw Exception("Location permission not granted");
      }
    } catch (e) {
      print("Error getting current position: $e");
      return _defaultPosition(); // Return the default position in case of an error
    }
  }

  void makeCall() async {
    try {
      bool? res = await FlutterPhoneDirectCaller.callNumber('+919111607983');
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      endDrawer: Drawer(
          child: ListView(
        children: const [
          Text("Home"),
        ],
      )),
      body: SlidingSheet(
        elevation: 20,
        cornerRadius: 50,
        snapSpec: const SnapSpec(
          // Enable snapping. This is true by default.
          snap: true,
          // Set custom snapping points.
          snappings: [0.4, 0.7, 1.0],
          // the total available space that the sheet can expand to.
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        // The body widget will be displayed under the SlidingSheet
        // and a parallax effect can be applied to it.
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 180),
          child: GestureDetector(
            onTap: () => _sendMessageWithLocation(
                '9827763713', 'All Task Clear Co-founder'),
            child: const CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/emergencyimg.png'),
            ),
          ),
        )),
        builder: (context, state) {
          // This is the content of the sheet that will get
          // scrolled, if the content is bigger than the available
          // height of the sheet.
          return SizedBox(
            height: 500,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  //row 1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Slidingsheet(
                        text: 'emergency call',
                        imagePath: 'assets/images/emergencycall.jpg',
                        onTap: () {
                          makeCall();
                        },
                      ),
                      Slidingsheet(
                        text: 'Women Helpline',
                        imagePath: 'assets/images/womenhelp.jpg',
                        onTap: () {},
                      ),
                    ],
                  ),

                  //row 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Slidingsheet(
                        text: 'Police',
                        imagePath: 'assets/images/dialhund.jpg',
                        onTap: () {},
                      ),
                      Slidingsheet(
                        text: 'Ambulacne',
                        imagePath: 'assets/images/ambulance.jpeg',
                        onTap: () {},
                      ),
                    ],
                  ),

                  //row 3
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Slidingsheet(
                        text: 'SMS',
                        imagePath: 'assets/images/sms.jpg',
                        onTap: () {},
                      ),
                      Slidingsheet(
                        text: 'Audio',
                        imagePath: 'assets/images/Voice.jpeg',
                        onTap: () {},
                      ),
                    ],
                  ),
                ]),
              ),
            )),
          );
        },
      ),
    );
  }
}
