class UserModel {
  final int id;
  final String username;
  final String email;
  final String? first_name;
  final String? last_name;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.first_name,
    this.last_name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      first_name: json['first_name'] ?? '',
      last_name: json['last_name'] ?? '',
    );
  }
}
