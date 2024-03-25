import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}
class _UserProfilePageState extends State<UserProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  File? _selectedImage;
  String? _currentUserImageURL; // Add this line

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _nameController.text = userDoc['name'] ?? '';
        _emailController.text = user.email ?? '';
        _currentUserImageURL = userDoc['imageURL']; // Update the image URL here
      });
    }
  }

  Future<void> _uploadProfileImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });

      User? user = _auth.currentUser;
      if (user != null) {
        final imagePath = 'profile_images/${user.uid}';
        final storageRef = _storage.ref().child(imagePath);
        final uploadTask = storageRef.putFile(_selectedImage!);

        await uploadTask.whenComplete(() async {
          final downloadURL = await storageRef.getDownloadURL();
          await _firestore.collection('users').doc(user.uid).update({
            'imageURL': downloadURL,
          });
        });
      }
    }
  }

  void _updateProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Update name in Firestore
      await _firestore.collection('users').doc(user.uid).update({
        'name': _nameController.text,
      });

      // Update name and email in FirebaseAuth
      await user.updateDisplayName(_nameController.text);
      await user.updateEmail(_emailController.text);

      // Update password in FirebaseAuth (if not empty)
      if (_passwordController.text.isNotEmpty) {
        await user.updatePassword(_passwordController.text);
      }
      
      // Navigate back to the Settings page
      Navigator.pop(context);
    }
  }

    ImageProvider<Object>? _imageProvider() {
    if (_selectedImage != null) {
      return FileImage(_selectedImage!);
    } else if (_currentUserImageURL != null) {
      return NetworkImage(_currentUserImageURL!);
    }
    return null;
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
            GestureDetector(
              onTap: _uploadProfileImage,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: _imageProvider(),
                  ),
                  SizedBox(height: 8),
                  Text('Upload Profile Picture'),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}





