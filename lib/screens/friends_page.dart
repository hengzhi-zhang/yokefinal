import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yoke_app4/person.dart';
import 'chat_screen.dart';  // Import your ConversationPage here

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  late Stream<QuerySnapshot> matchesStream;

  @override
  void initState() {
    super.initState();
    loadMatchesStream();
  }

  void loadMatchesStream() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    final userId = user.uid;

    matchesStream = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('matches')
      .snapshots();
  }

  void goToConversation(String friendId, String friendName, String friendImageUrl) { // Add friendImageUrl parameter
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          partnerId: friendId,
          partnerName: friendName,
          partnerImageUrl: friendImageUrl, // Pass the friend's image URL
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
        automaticallyImplyLeading: false,  // This removes the back button
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: matchesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No friends found.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var matchUserId = doc['matchId'];

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('users').doc(matchUserId).get(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> matchSnapshot) {
                  if (matchSnapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (matchSnapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  var matchData = matchSnapshot.data!.data() as Map<String, dynamic>;
                  var person = Person(
                    name: matchData['name'] ?? 'Unknown',
                    imageUrl: matchData['imageURL'] ?? '',
                    userId: matchUserId,
                  );

                  return ListTile(
                    title: Text(person.name),
                    subtitle: Text("Tap to chat"),
                    leading: (person.imageUrl.isNotEmpty)
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(person.imageUrl),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/0/0f/Grosser_Panda.JPG"),
                          ),
                    onTap: () {
                      goToConversation(person.userId, person.name, person.imageUrl);
                    },
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