import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yoke_app4/person.dart';
import 'chat_screen.dart'; // Import your ConversationPage here

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  late Stream<QuerySnapshot> conversationsStream;
  List<Person> matchedPartners = []; // Add this line

  @override
  void initState() {
    super.initState();
    loadConversationsStream();
  }

  void loadConversationsStream() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    final userId = user.uid;

    conversationsStream = FirebaseFirestore.instance
        .collection('conversations')
        .where('participants', arrayContains: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();

    matchedPartners.clear(); // Clear the list before updating

    conversationsStream.listen((snapshot) {
      matchedPartners.clear(); // Clear the list before updating

      for (var doc in snapshot.docs) {
        var participants = doc['participants'] as List<dynamic>;
        var partnerId = participants.firstWhere((id) => id != userId);

        FirebaseFirestore.instance
            .collection('users')
            .doc(partnerId)
            .get()
            .then((partnerSnapshot) {
          if (partnerSnapshot.exists) {
            var partnerData = partnerSnapshot.data() as Map<String, dynamic>;
            var person = Person(
              name: partnerData['name'] ?? 'Unknown',
              imageUrl: partnerData['imageURL'] ?? '',
              userId: partnerId,
            );
            matchedPartners.add(person);
            setState(() {}); // Trigger UI update
          }
        });
      }
    });
  }

  void goToConversation(String conversationId, String partnerName, String partnerId, String partnerImageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          conversationID: conversationId,
          partnerName: partnerName,
          partnerId: partnerId,
          partnerImageUrl: partnerImageUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: conversationsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No conversations found.'),
            );
          }

          return ListView.builder(
            itemCount: matchedPartners.length,
            itemBuilder: (context, index) {
              var person = matchedPartners[index];
              var doc = snapshot.data!.docs[index]; // Assuming each doc corresponds to a conversation

              return ListTile(
                title: Text(person.name),
                subtitle: Text("Tap to chat"),
                leading: (person.imageUrl.isNotEmpty)
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(person.imageUrl),
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/0/0f/Grosser_Panda.JPG"),
                      ),
                onTap: () {
                  goToConversation(
                    doc.id, // Conversation ID
                    person.name,
                    person.userId,
                    person.imageUrl,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}









/*whenever i find a match, i fixed an issue where i could match with the same person.
however, whenever i navigate to the friends page, there are duplicate names instead Off
the people that i have already matched with. */