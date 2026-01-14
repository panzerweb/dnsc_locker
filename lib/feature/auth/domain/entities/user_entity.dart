class UserEntity {
  final int id;
  final String username;
  final String email;
  final String? first_name;
  final String? last_name;

  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    this.first_name,
    this.last_name,
  });
}
