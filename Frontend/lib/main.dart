import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:women_safety_app/Screens/Profile.dart';
import 'package:women_safety_app/Screens/askdetails.dart';
import 'package:women_safety_app/Screens/homeScreen.dart';
import 'package:women_safety_app/Screens/tabNavigation.dart';
// import 'package:workmanager/workmanager.dart';

import 'Screens/loginScreen.dart';
import 'DBhelper/db_connection.dart';

void main() async {

  await dbConnection.connect();
  print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiuuuuuuuuuuuuuuuuuulllll");

  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
 
}
