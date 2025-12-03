import 'package:trip_match/models/schedule.dart';

import 'Include.dart';
import 'experienceImage.dart';

class Experience {
  int? id;
  String? title;
  String? description;
  String? location;
  double? price;
  int? duration;
  String? frequencies;
  int? categoryId;
  String? agencyUserId;

  List<ExperienceImage>? experienceImages;
  List<Include>? includes;
  List<Schedule>? schedules;

  Experience({
    this.id,
    this.title,
    this.description,
    this.location,
    this.price,
    this.duration,
    this.frequencies,
    this.categoryId,
    this.agencyUserId,
    this.experienceImages,
    this.includes,
    this.schedules,
  });

  Experience.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    location = json['location'];
    price = json['price']?.toDouble();
    duration = json['duration'];
    frequencies = json['frequencies'];
    categoryId = json['categoryId'];
    agencyUserId = json['agencyUserId'];

    experienceImages = (json['experienceImages'] != null && json['experienceImages'] is List)
        ? (json['experienceImages'] as List)
        .map((e) => ExperienceImage.fromJson(e))
        .toList()
        : [];

    includes = (json['includes'] != null && json['includes'] is List)
        ? (json['includes'] as List)
        .map((e) => Include.fromJson(e))
        .toList()
        : [];

    schedules = (json['schedules'] != null && json['schedules'] is List)
        ? (json['schedules'] as List)
        .map((e) => Schedule.fromJson(e))
        .toList()
        : [];

  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "location": location,
      "price": price,
      "duration": duration,
      "frequencies": frequencies,
      "categoryId": categoryId,
      "agencyUserId": agencyUserId,
      "experienceImages": experienceImages?.map((e) => e.toJson()).toList(),
      "includes": includes?.map((e) => e.toJson()).toList(),
      "schedules": schedules?.map((e) => e.toJson()).toList(),
    };
  }
}
