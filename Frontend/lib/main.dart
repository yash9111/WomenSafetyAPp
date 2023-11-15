import 'dart:developer';

import 'package:flutter/material.dart';

import 'Screens/loginScreen.dart';
import 'DBhelper/db_connection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbConnection.connect();
  print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiuuuuuuuuuuuuuuuuuulllll");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
