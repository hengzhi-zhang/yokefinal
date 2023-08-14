import 'package:flutter/material.dart';
import 'screens/home_page.dart';  // Ensure paths are correct
import 'screens/friends_page.dart';
import 'screens/settings_page.dart';
import 'screens/splash_screen.dart';
import 'person.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



 // This assumes you have created splash_screen.dart as shown in a previous answer.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyD4v7aJO6mnJ-WL-d1QFLNX8CmXRMRLhxM',
    appId: '1:1074506106271:ios:ade2ea51437bc60aeca9aa',
    messagingSenderId: '1074506106271',
    projectId: 'yoke-f9158',
    storageBucket: 'yoke-f9158.appspot.com',
    iosClientId: '1074506106271-baoj226s7ntnjjdabta215ebceu2062b.apps.googleusercontent.com',
    iosBundleId: 'com.example.yokeApp4'
    ),
  );
  runApp(MyApp());
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
    FriendsPage(matchedPartners: globalMatchedPartners),
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
        showSelectedLabels: false,  // Hide the labels for selected items
        showUnselectedLabels: false,  // Hide the labels for unselected items
        selectedItemColor: Colors.yellow[800],  // Dark yellow for the selected item
        unselectedItemColor: Colors.grey,  // Default color for unselected items, you can adjust this if needed
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Partners"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}



