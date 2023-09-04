import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/friends_page.dart';
import 'screens/settings_page.dart';

class BottomNavigationController extends StatefulWidget {
  @override
  _BottomNavigationControllerState createState() => _BottomNavigationControllerState();
}

class _BottomNavigationControllerState extends State<BottomNavigationController> {
  int _currentIndex = 0;
  late List<Widget> _pages;  // Declare it here but don't initialize

  // Handle new match action, you can extend this function as needed
  void _handleNewMatch() {
    // Do something when a new match is made
  }

  @override
  void initState() {
    super.initState();
    // Initialize _pages in initState
    _pages = [
      HomePage(
        onNewMatch: _handleNewMatch,  // You can safely use it here
      ),
      FriendsPage(),
      SettingsPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Friends"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}


