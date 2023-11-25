// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:women_safety_app/Screens/homeScreen.dart';
import 'package:women_safety_app/Screens/Map.dart';
import 'package:women_safety_app/Screens/tips.dart';
import 'package:women_safety_app/Screens/Profile.dart';

class tabNavigation extends StatefulWidget {
  const tabNavigation({Key? key});

  @override
  State<tabNavigation> createState() => _tabNavigationState();
}

class _tabNavigationState extends State<tabNavigation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: Text("Rakshika"),
            backgroundColor: Colors.pink.shade400,
            bottom: TabBar(
              labelStyle: TextStyle(fontSize: 15),
              tabs: <Widget>[
                Tab(text: "Home"),
                Tab(text: 'Map'),
                Tab(text: 'Tips'),
                Tab(
                  text: 'Posts',
                ),
              ],
            ),
            actions: <Widget>[
              Builder(
                // Wrap the IconButton in a Builder
                builder: (BuildContext builderContext) {
                  return IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      // Handle settings button press
                      Scaffold.of(builderContext).openEndDrawer();
                    },
                  );
                },
              ),
            ],
          ),
          endDrawer: Drawer(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  title: Text("Profile"),
                  onTap: () {
                    // Handle the item 1 click
                  },
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  title: Text("Add new contacts"),
                  onTap: () {
                    // Handle the item 2 click
                  },
                ),
                Divider(
                  color: Colors.black,
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[Home(), Map(), Tips(), Profile()],
          ),
        ),
      ),
    );
  }
}
