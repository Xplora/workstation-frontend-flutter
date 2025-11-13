import 'package:flutter/material.dart';
import 'package:trip_match/models/experience.dart';

final ValueNotifier<Set<String>> favoritesNotifier = ValueNotifier<Set<String>>(<String>{});

bool isFavoriteById(String id) => favoritesNotifier.value.contains(id);

void toggleFavoriteById(String id) {
  final newSet = {...favoritesNotifier.value};
  if (newSet.contains(id)) {
    newSet.remove(id);
  } else {
    newSet.add(id);
  }
  favoritesNotifier.value = newSet;
}

/// devuelve las experiencias mockeadas que están seleccionadas como favorites por id
List<Experience> favoriteExperiences() {
  final all = MockData.getExperiences();
  return all.where((e) => favoritesNotifier.value.contains(e.id)).toList();
}
