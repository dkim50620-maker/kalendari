class User {
  final int id;
  final String firstName;

  const User({
    required this.id,
    required this.firstName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final user = json['users'][0];

    return User(
      id: user['id'],
      firstName: user['firstName'],
    );
  }
}

