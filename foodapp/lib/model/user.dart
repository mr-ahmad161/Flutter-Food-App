import 'package:foodapp/core/user-role.enum.dart';

class User {
  UserRole role;
  String fullName;
  String email;
  String message;

  String get getRole {
    return role.toString();
  }

  User({
    this.role = UserRole.User,
    this.fullName = "",
    this.email = "",
    this.message="",
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["emai"],
        role: UserRole.values.byName(json["role"]),
        fullName: json["fullName"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['role'] = UserRole.values.byName(data['role']).toString();
    data['fullName'] = fullName;
    data['emai'] = email;
    data['message'] = message;
    return data;
  }
}
