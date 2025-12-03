import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trip_match/IAM/services/authSession.dart';
import 'package:trip_match/models/tourist.dart';
import '../models/category.dart';
import '../models/experience.dart';
import '../models/favorite.dart';
import '../models/user.dart';

class HttpHelper {
//final String urlBase = 'http://localhost:5260/';
  final String urlBase = 'https://xplora-backend.onrender.com/';
  final String urlKey = 'api/v1/';
  final String urlExperiences = 'design/experience/';
  final String urlCategory = 'design/category';
  final String urlUsers = 'profile/user/';
  final String urlTourist = 'profile/user/tourist/';
  final String urlFavorite = 'design/favorite/favorite';


  //                  EXPERIENCE


  Future<List<Experience>> getExperiences() async {
    final token = await AuthSession.getToken();

    final res = await http.get(
      Uri.parse('$urlBase$urlKey$urlExperiences'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (res.statusCode == 200) {
      final data = json.decode(res.body);

      List<Experience> experiences =
      (data as List).map((item) => Experience.fromJson(item)).toList();

      return experiences;
    } else {
      throw Exception('Error al obtener experiencias: ${res.statusCode}');
    }
  }

  Future<Experience> getExperienceById(String id) async {
    final token = await AuthSession.getToken();

    final res = await http.get(
      Uri.parse('$urlBase$urlKey$urlExperiences$id'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return Experience.fromJson(data);
    } else {
      throw Exception('Error al obtener experiencia con id $id: ${res.statusCode}');
    }
  }


  //               CATEGORY


  Future<List<Category>> getCategories() async {
    final token = await AuthSession.getToken();

    final res = await http.get(
      Uri.parse('$urlBase$urlKey$urlCategory'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (res.statusCode == 200) {
      final data = json.decode(res.body);

      List<Category> categories =
      (data as List).map((item) => Category.fromJson(item)).toList();

      return categories;
    } else {
      throw Exception('Error al obtener categorías: ${res.statusCode}');
    }
  }


  //                    USER


  Future<User> getUser(String id) async {
    final token = await AuthSession.getToken();

    final res = await http.get(
      Uri.parse('$urlBase$urlKey$urlUsers$id'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return User.fromJson(data);
    } else {
      throw Exception('Error al obtener usuario: ${res.statusCode}');
    }
  }

  Future<Tourist> getTourist(String id) async {
    final token = await AuthSession.getToken();

    final res = await http.get(
      Uri.parse('$urlBase$urlKey$urlTourist$id'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return Tourist.fromJson(data);
    } else {
      throw Exception('Error al obtener tourist: ${res.statusCode}');
    }
  }


  //                    FAVORITE

  Future<List<Favorite>> getFavorites(String touristId) async {
    final token = await AuthSession.getToken();

    final res = await http.get(
      Uri.parse('$urlBase$urlKey$urlFavorite/tourist/$touristId'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );

    if (res.statusCode == 200) {
      final jsonList = json.decode(res.body) as List;
      return jsonList.map((e) => Favorite.fromJson(e)).toList();
    } else {
      throw Exception("Error al obtener favoritos: ${res.statusCode}");
    }
  }


  Future<bool> addFavorite(String touristId, int experienceId) async {
    final token = await AuthSession.getToken();

    final body = json.encode({
      "touristId": touristId,
      "experienceId": experienceId
    });

    final res = await http.post(
      Uri.parse('$urlBase$urlKey$urlFavorite'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: body,
    );

    return res.statusCode == 201 || res.statusCode == 200;
  }

  Future<bool> deleteFavorite(int favoriteId) async {
    final token = await AuthSession.getToken();

    final res = await http.delete(
      Uri.parse('$urlBase$urlKey$urlFavorite$favoriteId'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );

    return res.statusCode == 200 || res.statusCode == 204;
  }


  Future<List<Experience>> getFavoriteExperiences(String touristId) async {
    try {
      final favorites = await getFavorites(touristId);

      final experienceIds = favorites.map((f) => f.experienceId).whereType<String>().toList();

      final experienceFutures = experienceIds.map((id) => getExperienceById(id));

      final experiences = await Future.wait(experienceFutures);

      return experiences;
    } catch (e) {
      print("Error al cargar las experiencias favoritas: $e");
      return [];
    }
  }


}