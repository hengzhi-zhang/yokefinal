import 'package:flutter/material.dart';
import 'screens/home_page.dart';  // Ensure paths are correct
import 'screens/friends_page.dart';
import 'screens/settings_page.dart';
import 'screens/splash_screen.dart';  // This assumes you have created splash_screen.dart as shown in a previous answer.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yoke',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: Colors.yellow),
        useMaterial3: true,
      ),
      
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(), 
        '/home': (context) => MyHomePage(title: 'Yoke'),
        // add other routes if needed
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    FriendsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(widget.title),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

