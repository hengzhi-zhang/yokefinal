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
            // Navigate to User Profile details
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage()));
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Preferences'),
          onTap: () {
            // Navigate to Preferences page or perform other actions
            Navigator.push(context, MaterialPageRoute(builder: (context) => PreferencesPage()));
          },
        ),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('About'),
          onTap: () {
            // Navigate to About page or show about details
            Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
          },
        ),
        ListTile(
          leading: Icon(Icons.feedback),
          title: Text('Feedback'),
          onTap: () {
            // Navigate to Feedback form
            Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
          },
        ),
      ],
    );
  }
}

// You can now remove the placeholder UserProfilePage class since you've created a separate file for it.





