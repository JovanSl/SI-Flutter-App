import 'package:flutter/cupertino.dart';
@immutable
class User {
  final String id;
  final String email;
  final String userRole;

  const User({this.id, this.email, this.userRole});

  User.fromData(Map<String, dynamic>data)
      : id = data['id'],
        email = data['email'],
        userRole = data['role'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userRole': userRole,
    };
  }
}