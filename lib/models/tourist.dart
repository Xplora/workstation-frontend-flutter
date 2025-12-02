import 'package:trip_match/models/user.dart';

class Tourist {
  String? userId;
  String? avatarUrl;

  Tourist({
    this.userId,
    this.avatarUrl,
  });

  Tourist.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = this.userId;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': userId,
      'avatarUrl': avatarUrl,
    };
  }
}