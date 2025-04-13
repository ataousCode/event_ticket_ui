// lib/app/data/models/user_model.dart
class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final bool emailVerified;
  final bool phoneVerified;
  final String? profileImageUrl;
  final List<String> roles;
  final bool active;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    required this.emailVerified,
    required this.phoneVerified,
    this.profileImageUrl,
    required this.roles,
    required this.active,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      emailVerified: json['emailVerified'] ?? false,
      phoneVerified: json['phoneVerified'] ?? false,
      profileImageUrl: json['profileImageUrl'],
      roles: List<String>.from(json['roles'] ?? []),
      active: json['active'] ?? true,
    );
  }
}
