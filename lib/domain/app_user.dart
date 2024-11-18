class AppUser {
  String uid;
  String name;
  String lastName;
  String email;
  String password;
  String role;

  AppUser(
      {this.uid = '',
      this.name = 'John',
      this.lastName = 'Doe',
      this.email = 'john@doe.com',
      this.password = '123',
      this.role = 'Cliente'});

  factory AppUser.fromMap(userMap) {
    return AppUser(
      uid: userMap['uid'],
      name: userMap['name'],
      lastName: userMap['lastName'],
      email: userMap['email'],
      role: userMap['role'],
    );
  }

  bool isCustomer() => role == 'Cliente';

  Map<String, String> toMap() {
    return {
      "uid": uid,
      "name": name,
      "lastName": lastName,
      "email": email,
      "role": role,
    };
  }
}
