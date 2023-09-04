import 'package:flutter/foundation.dart';

class Conversation {
  final String partnerName;
  final String partnerId;
  final String lastMessage;

  Conversation({
    required this.partnerName,
    required this.partnerId,
    required this.lastMessage,
  });
}

class ConversationsModel extends ChangeNotifier {
  List<Conversation> _conversations = [];

  List<Conversation> get conversations => _conversations;

  void addConversation({
    required String partnerName,
    required String partnerId,
    required String lastMessage,
  }) {
    _conversations.add(
      Conversation(
        partnerName: partnerName,
        partnerId: partnerId,
        lastMessage: lastMessage,
      ),
    );
    notifyListeners();
  }
}

