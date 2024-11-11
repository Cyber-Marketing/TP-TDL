class AppUser {
  String uid;
  String email;
  String role;

  AppUser({required this.uid, required this.email, required this.role});

  factory AppUser.fromMap(userMap) {
    return AppUser(
      uid: userMap['uid'],
      email: userMap['email'],
      role: userMap['role'],
    );
  }

  bool isCustomer() => role == 'Cliente';
}
