

import 'package:trip_match/models/tourist.dart';

class User {
  String? userId; // Usamos String para el Guid/UUID
  String? firstName;
  String? lastName;
  String? number;
  String? email;
  String? password;
  Tourist? tourist;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.number,
    this.email,
    this.password,
    this.tourist,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    number = json['number'];
    email = json['email'];
    password = json['password'];
    tourist = json['tourist'] != null ? Tourist.fromJson(json['tourist']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['number'] = this.number;
    data['email'] = this.email;
    data['password'] = this.password;
    if (tourist != null) {
      data['tourist'] = tourist!.toJson();
    }
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'firstName': firstName,
      'email': email,
    };
  }
}