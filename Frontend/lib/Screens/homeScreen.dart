// ignore_for_file: file_names

import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_sheet2/sliding_sheet2.dart';
import 'slidingsheet.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geocoding/geocoding.dart';

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

      // Get location name from coordinates
      String locationName = await _getLocationName(latitude, longitude);

      final messageWithLocation =
          "Help! Location: $locationName, Latitude: $latitude, Longitude: $longitude\n$message";

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

  Future<String> _getLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.name}, ${place.locality}, ${place.country}";
      } else {
        return 'Location not found';
      }
    } catch (e) {
      print("Error: $e");
      return 'Failed to get location';
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
      // appBar: AppBar(
      //   title: const Text(
      //     "Rakshikha",
      //     style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: Colors.pink.shade100,
      // ),
      // endDrawer: Drawer(
      //     backgroundColor: Colors.white,
      //     child: ListView(
      //       children: const [
      //         Text("data"),
      //       ],
      //     )),
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
            onTap: () {
              print("Image pressed ");
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Send SOS"),
                    content: const Text(
                        "Are you sure you want to send SOS to your eergency contacts?"),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "cancle",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                          )),
                      TextButton(
                          onPressed: () {
                            _sendMessageWithLocation(
                                '9827763713', 'All Task Clear Co-founder');

                            Fluttertoast.showToast(
                                msg:
                                    "Emergency alert sent with your current location.",
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.pink.shade400,
                                textColor: Colors.white);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "send",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                          )),
                    ],
                  );
                },
              );
            },
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
            height: 600,
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
                        onTap: () {
                          makeCall();
                        },
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
                        onTap: () {
                          makeCall();
                        },
                      ),
                      Slidingsheet(
                        text: 'Ambulacne',
                        imagePath: 'assets/images/ambulance.jpeg',
                        onTap: () {
                          makeCall();
                        },
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
                        onTap: () {
                          makeCall();
                        },
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
