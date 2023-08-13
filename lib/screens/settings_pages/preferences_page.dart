import 'package:flutter/material.dart';
import 'new_multiselect_widget.dart';

class PreferencesPage extends StatefulWidget {
  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  List<String> _preferredGenders = ["Any"];
  String _preferredLocation = "Running";
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Match Preferences
            ListTile(
              title: Text('Preferred Gender', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: MultiSelectDropdown(  // Using it as a subtitle instead of trailing
                items: ['Men', 'Women', 'Non-Binary', 'Any'],
                selectedItems: _preferredGenders,
                onSelectionChanged: (selectedList) {
                  setState(() {
                    _preferredGenders = selectedList;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Preferred Activity', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: DropdownButton<String>(
                value: _preferredLocation,
                items: <String>['Running', 'Workout'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _preferredLocation = newValue!;
                  });
                },
              ),
            ),

            Divider(),

            // Theme & Appearance
            ListTile(
              title: Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
              ),
            ),

            Divider(),

            // Safety Guidelines
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Safety Guidelines'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SafetyGuidelinesPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SafetyGuidelinesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safety Guidelines'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Here, you can list out all your safety guidelines and best practices for users.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}






