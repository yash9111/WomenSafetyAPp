import 'package:flutter/material.dart';

import 'Screens/loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("helo");
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      
    );
  }
}
