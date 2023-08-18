import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ChatScreen extends StatefulWidget {
  final String partnerName;
  final String partnerId;

  ChatScreen({required this.partnerName, required this.partnerId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  String _currentUserName = "";  // Initialize with an empty string

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserName();
  }

  // Fetch the current user's name
  Future<void> _fetchCurrentUserName() async {
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUserId).get();
  setState(() {
    _currentUserName = userDoc.data()?.containsKey('name') ?? false
      ? userDoc.get('name') ?? ""
      : "Unknown";
  });
}

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(widget.partnerId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                return ListView(
                  reverse: true,
                  children: snapshot.data!.docs.map((doc) {
                    return ListTile(
                      title: Text(doc['senderName']),  // Display the sender's name instead of the UID
                      subtitle: Text(doc['text']),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Enter your message...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    final message = _controller.text;
                    _controller.clear();
                    await FirebaseFirestore.instance
    .collection('chats')
    .doc(widget.partnerId)
    .collection('messages')
    .add({
  'senderID': currentUserId,
  'text': message,
  'timestamp': FieldValue.serverTimestamp(),
  'senderName': _currentUserName,
});
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}



