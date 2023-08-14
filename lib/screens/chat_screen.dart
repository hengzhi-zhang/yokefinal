// chat_screen.dart
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String partnerName;

  ChatScreen({required this.partnerName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat with ${widget.partnerName}')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              // Here you can build your list of messages
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
                  onPressed: () {
                    // Logic to send the message
                    final message = _controller.text;
                    _controller.clear();
                    print("Message sent: $message"); // Temporary logic for demonstration purposes
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