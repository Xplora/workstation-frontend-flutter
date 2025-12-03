import 'package:flutter/material.dart';
import 'package:trip_match/models/experience.dart';

import '../utils/http_helper.dart';

final ValueNotifier<Set<String>> favoritesNotifier = ValueNotifier<Set<String>>(<String>{});
final helper = HttpHelper();

bool isFavoriteById(String id) => favoritesNotifier.value.contains(id);

Future<void> toggleFavoriteById(String id, String userId) async {
  final newSet = {...favoritesNotifier.value};

  if (newSet.contains(id)) {
    newSet.remove(id);
    await helper.deleteFavorite(int.parse(id));
  } else {
    newSet.add(id);
    await helper.addFavorite(userId, int.parse(id));
  }

  favoritesNotifier.value = newSet;
}

Future<void> loadFavoritesFromDB(String userId) async {
  final favList = await helper.getFavorites(userId); // <-- tu GET al backend
  final favIds = favList.map((f) => f.experienceId.toString()).toSet();

  favoritesNotifier.value = favIds;
}

/*
/// devuelve las experiencias mockeadas que están seleccionadas como favorites por id
List<Experience> favoriteExperiences() {
  final all = MockData.getExperiences();
  return all.where((e) => favoritesNotifier.value.contains(e.id)).toList();
}
*/