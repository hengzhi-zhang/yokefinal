import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'package:yoke_app4/person.dart';

class FriendsPage extends StatefulWidget {
  final List<Person> matchedPartners;

  FriendsPage({required this.matchedPartners});

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matches'),
        automaticallyImplyLeading: false, // Add this line
      ),
      body: (widget.matchedPartners.isEmpty)
          ? Center(child: Text('No matches found.'))
          : ListView.builder(
              itemCount: widget.matchedPartners.length,
              itemBuilder: (context, index) {
                final partner = widget.matchedPartners[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(partner.imageUrl),
                  ),
                  title: Text(partner.name),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ChatScreen(partnerName: partner.name, partnerId: partner.userId), // Pass the userId here
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
