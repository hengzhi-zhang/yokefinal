import 'package:flutter/material.dart';
import 'screens/home_page.dart';  // Ensure paths are correct
import 'screens/friends_page.dart';
import 'screens/settings_page.dart';
import 'screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/settings_pages/userProfiles_page.dart';
import 'screens/settings_pages/preferences_page.dart';
import 'screens/settings_pages/about_page.dart';
import 'screens/settings_pages/feedback_page.dart';
import 'bottom_navigation_controller.dart';

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
  @override
  Widget build(BuildContext context) {
    // Check authentication status
    final initialRoute = FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/home';

    return MaterialApp(
      title: 'Yoke',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: const Color.fromARGB(255, 223, 202, 7),),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      routes: {
        '/': (context) => AuthScreen(),
        '/sign-in': (context) => AuthScreen(),
        '/home': (context) => MyHomePage(title: 'Yoke'),
        '/user-profile': (context) => UserProfilePage(),
        '/preferences': (context) => PreferencesPage(),
        '/about': (context) => AboutPage(),
        '/feedback': (context) => FeedbackPage(),
        '/settings': (context) => SettingsPage(),
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
    HomePage(
      onNewMatch: () {
        // You can add additional actions here if needed when a new match occurs.
      },
    ),
    FriendsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(widget.title),
        automaticallyImplyLeading: false,
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





