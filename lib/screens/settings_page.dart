import 'package:flutter/material.dart';
import 'settings_pages/feedback_page.dart';
import 'settings_pages/userProfiles_page.dart';
import 'settings_pages/about_page.dart';
import 'settings_pages/preferences_page.dart';  // Import the new user profile page here

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
  leading: Icon(Icons.person),
  title: Text('User Profile'),
  onTap: () {
    // Navigate to User Profile details using a named route
    Navigator.pushNamed(context, '/user-profile');
  },
),
ListTile(
  leading: Icon(Icons.settings),
  title: Text('Preferences'),
  onTap: () {
    // Navigate to Preferences page using a named route
    Navigator.pushNamed(context, '/preferences');
  },
),
ListTile(
  leading: Icon(Icons.info_outline),
  title: Text('About'),
  onTap: () {
    // Navigate to About page using a named route
    Navigator.pushNamed(context, '/about');
  },
),
ListTile(
  leading: Icon(Icons.feedback),
  title: Text('Feedback'),
  onTap: () {
    // Navigate to Feedback form using a named route
    Navigator.pushNamed(context, '/feedback');
  },
),

      ],
    );
  }
}

// You can now remove the placeholder UserProfilePage class since you've created a separate file for it.





