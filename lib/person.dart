class Person {
  final String name;
  final String imageUrl;
  final String userId;
  final List<String> conversationIds; // Update to a List

  Person({
    required this.name,
    required this.imageUrl,
    required this.userId,
    List<String>? conversationIds, // Update to accept a List of conversation IDs
  }) : conversationIds = conversationIds ?? []; // Initialize with an empty List if null
}
