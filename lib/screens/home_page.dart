import 'package:flutter/material.dart';
import 'dart:math';
import 'chat_screen.dart';
import 'friends_page.dart';
import 'package:yoke_app4/person.dart';

final List<Person> people = [
  Person(name: 'Hengzhi Zhang', imageUrl: '/Users/hengzhi/Downloads/IMG_4800.JPG'),
  Person(name: 'Robert Pham', imageUrl: '/Users/hengzhi/Downloads/IMG_0783.JPG'),
  Person(name: 'Andrew Wang', imageUrl: '/Users/hengzhi/Downloads/Screenshot_20170112-153230.png'),
  Person(name: 'Morgan Handojo', imageUrl: '/Users/hengzhi/Downloads/FullSizeRender.jpeg'),
  Person(name: 'Jaden Yi', imageUrl: '/Users/hengzhi/Downloads/IMG_2458.jpg'),
  // ... same list of people
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _findPartner() {
    // Create a list of potential matches excluding those already in globalMatchedPartners
    List<Person> potentialMatches = people.where((person) => !globalMatchedPartners.contains(person)).toList();
    
    if (potentialMatches.isEmpty) {
      // Handle case where there are no more potential matches
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No More Matches'),
            content: Text('You have chatted with everyone!'),
            actions: <Widget>[
              TextButton(
                child: Text('Okay', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    final randomIndex = Random().nextInt(potentialMatches.length);
    final partner = potentialMatches[randomIndex];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(partner.imageUrl),
              ),
              SizedBox(height: 20),
              Text(
                'Partner found: ${partner.name}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Chat', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(partnerName: partner.name),
                  ),
                );
                if (!globalMatchedPartners.contains(partner)) {
                  globalMatchedPartners.add(partner);
                }
              },
            ),
            TextButton(
              child: Text('Close', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.group),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FriendsPage(matchedPartners: globalMatchedPartners),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _findPartner,
          child: Text(
            'Find a Partner',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.white, // This is the button color
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: HomePage()));








