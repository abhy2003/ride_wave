class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }
}