import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  String _gradeLevel = 'Freshman';  // Default value
  TextEditingController _majorController = TextEditingController();

  void _saveProfile() {
    // TODO: Implement your save logic here
    print("Saved!");
    // For example, you can send this data to a server or save it locally.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            InkWell(
              onTap: () async {
                final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _imageFile = pickedFile;
                  });
                }
              },
              child: CircleAvatar(
                radius: 120,
                backgroundImage: _imageFile != null
    ? FileImage(File(_imageFile!.path)) as ImageProvider
    : AssetImage('/Users/hengzhi/Downloads/default_image.jpg'),   // Ensure you've added this image in your assets folder and updated pubspec.yaml
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField(
              value: _gradeLevel,
              items: ['Freshman', 'Sophomore', 'Junior', 'Senior'].map((String grade) {
                return DropdownMenuItem(
                  value: grade,
                  child: Text(grade),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _gradeLevel = newValue.toString();
                });
              },
              decoration: InputDecoration(
                labelText: 'Grade Level',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _majorController,
              decoration: InputDecoration(
                labelText: 'Major',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
  onPressed: _saveProfile,
  child: Text("Save", style: TextStyle(color: Colors.black)),
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
  ),
),
          ],
        ),
      ),
    );
  }
}




