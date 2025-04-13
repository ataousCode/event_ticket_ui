// lib/app/data/models/auth_response_model.dart
class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final String id;
  final String email;
  final List<String> roles;
  final int expiresIn;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.id,
    required this.email,
    required this.roles,
    required this.expiresIn,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      tokenType: json['tokenType'],
      id: json['id'],
      email: json['email'],
      roles: List<String>.from(json['roles']),
      expiresIn: json['expiresIn'],
    );
  }
}
