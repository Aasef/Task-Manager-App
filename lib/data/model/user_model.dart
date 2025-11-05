class UserModel {
  final String id;
  final String firstName;

  final String lastName;
  final String email;
  final String mobile;

  String get fullName{
    return '$firstName $lastName';
  }

  UserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.mobile});

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        id: jsonData['_id'],
        firstName: jsonData['firstName'],
        lastName: jsonData['lastName'],
        email: jsonData['email'],
        mobile: jsonData['mobile']);
  }

  Map<String, dynamic> toJason() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobile': mobile
    };
  }
}
