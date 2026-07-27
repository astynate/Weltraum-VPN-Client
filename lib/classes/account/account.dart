class Account {
  final String id;
  final String email;

  Account({required this.id, required this.email});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      email: json['email'],
    );
  }
}