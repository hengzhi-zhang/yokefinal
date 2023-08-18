class Person {
  final String name;
  final String imageUrl;
  final String userId; // Add this field

  Person({
    required this.name,
    required this.imageUrl,
    required this.userId, // Add this parameter
  });
}

List<Person> globalMatchedPartners = [];