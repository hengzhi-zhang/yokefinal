import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Introduction/Mission Statement
            Text(
              'About Yoke',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '''Our mission is to cultivate a vibrant community where fitness enthusiasts can unite, share, and inspire. Through our app, we aim to foster connections among those passionate about working out, making every fitness journey more inclusive and collaborative.''',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),

            // Team Bio
            Text(
              'Meet The Team',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('/Users/hengzhi/Downloads/IMG_4800.JPG'), // Path to your image
              ),
              title: Text(
                'Hengzhi Zhang', 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Founder & Developer\n\n'
                'I started this project to get some real-world experience coding a production-level app from scratch. '
                'I love everyone :)',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            // You can add more team members in a similar format if needed.

            // Any additional sections you want to add...
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: AboutPage()));

