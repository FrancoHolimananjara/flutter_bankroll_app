class User {
  final String token;
  final String id;
  final String username;
  final String email;
  final String password;
  final List<String> ofsessions;
  final List<String> oftransactions;
  final String ofbaknroll;

  const User({
    required this.token,
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.ofsessions,
    required this.oftransactions,
    required this.ofbaknroll,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      ofsessions: json['ofsessions'],
      oftransactions: json['oftransactions'],
      ofbaknroll: json['ofbaknroll'],
    );
  }
}
