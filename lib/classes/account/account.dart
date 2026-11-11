class Account {
  final String id;
  final String email;
  final String fullName;
  final String avatar;

  Account({
    required this.id, 
    required this.email, 
    required this.fullName, 
    required this.avatar
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      email: json['email'], 
      fullName: json['fullName'], 
      avatar: json['avatar'],
    );
  }
}