import 'package:trip_match/models/tourist.dart';

class User {
  String? userId;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? password;
  Tourist? tourist;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.password,
    this.tourist,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'firstName': firstName,
      'email': email,
      'phone': phone, // Usando 'phone' en toMap
    };
  }
}