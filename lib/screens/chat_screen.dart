import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  final String partnerName;
  final String partnerId;
  final String partnerImageUrl; // Add this line

  ChatScreen({
    required this.partnerName,
    required this.partnerId,
    required this.partnerImageUrl, // Add this line
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  String _currentUserName = "";

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserName();
  }

  Future<void> _fetchCurrentUserName() async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(currentUserId).get();
    setState(() {
      _currentUserName = userDoc.data()?.containsKey('name') ?? false
          ? userDoc.get('name') ?? ""
          : "Unknown";
    });
  }

  String _getConversationId(String userId1, String userId2) {
    List<String> participants = [userId1, userId2];
    participants.sort(); // Sorting ensures consistent conversation IDs
    return participants.join('_');
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    final conversationId = _getConversationId(currentUserId, widget.partnerId);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.partnerImageUrl),
            ),
            SizedBox(width: 10),
            Text(widget.partnerName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('conversations')
                  .doc(conversationId)
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
                      title: Text(doc['senderName']),
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

                    final currentTime = FieldValue.serverTimestamp();

                    // Add message to the conversation
                    await FirebaseFirestore.instance
                        .collection('conversations')
                        .doc(conversationId)
                        .collection('messages')
                        .add({
                      'senderID': currentUserId,
                      'text': message,
                      'timestamp': currentTime,
                      'senderName': _currentUserName,
                    });

                    // Update the conversation details in the conversations collection
                    await FirebaseFirestore.instance
                        .collection('conversations')
                        .doc(conversationId)
                        .set({
                      'lastMessage': message,
                      'timestamp': currentTime,
                      'participants': [currentUserId, widget.partnerId],
                      'partnerName': widget.partnerName,
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}




