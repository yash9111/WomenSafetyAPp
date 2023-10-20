import 'package:flutter/material.dart';

import 'Screens/loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:women_safety_app/Screens/homeScreen.dart';
// import 'package:women_safety_app/Screens/Map.dart';
// import 'package:women_safety_app/Screens/tips.dart';
// import 'package:women_safety_app/Screens/Profile.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DefaultTabController(
//         length: 4, // Number of tabs
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.pink.shade400,
//             bottom: TabBar(
//               tabs: <Widget>[
//                 Tab(text: "Home"),
//                 Tab(text: 'Map'),
//                 Tab(text: 'Tips'),
//                 Tab(text: 'Profile'),
//               ],
//             ),
//           ),
//           body: TabBarView(
//             children: <Widget>[Home(), Map(), Tips(), Profile()],
//           ),
//         ),
//       ),
//     );
//   }
// }
