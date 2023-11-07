import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';
import 'package:women_safety_app/Screens/homeScreen.dart';
import 'package:women_safety_app/Screens/Map.dart';
import 'package:women_safety_app/Screens/tips.dart';
import 'package:women_safety_app/Screens/Profile.dart';

class tabNavigation extends StatefulWidget {
  const tabNavigation({super.key});

  @override
  State<tabNavigation> createState() => _tabNavigationState();
}

class _tabNavigationState extends State<tabNavigation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: DefaultTabController(animationDuration: const Duration(seconds: 1),
        length: 4, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink.shade100,
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(text: "Home"),
                Tab(text: 'Map'),
                Tab(text: 'Tips'),
                Tab(text: 'Profile'),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[Home(), Map(), Tips(), Profile()],
          ),
        ),
      ),
    );
  }
}
