import 'package:flutter/material.dart';
import 'package:trip_match/models/experience.dart';

class ItineraryItem {
  final String id;
  final Experience experience;
  final String date;
  final int people;
  final double totalPrice;
  final String schedule;

  ItineraryItem({
    required this.id,
    required this.experience,
    required this.date,
    required this.people,
    required this.totalPrice,
    required this.schedule,
  });
}

final ValueNotifier<List<ItineraryItem>> itineraryNotifier = ValueNotifier<List<ItineraryItem>>([]);

void addItineraryItem(ItineraryItem item) {
  final list = List<ItineraryItem>.from(itineraryNotifier.value);
  list.add(item);
  itineraryNotifier.value = list;
}
