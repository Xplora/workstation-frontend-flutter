import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trip_match/models/tourist.dart';
import '../models/category.dart';
import '../models/experience.dart';
import '../models/user.dart';

class HttpHelper {
  final String urlBase = 'https://xplora-backend.onrender.com';
  final String urlKey = '/api/v1/';
  final String urlExperiences = 'design/experience';
  final String urlCategory = 'design/category';
  final String urlUsers = 'profile/user/';
  final String urlTourist = 'profile/user/tourist/';
  final String urlAuth = 'iam/auth';

  Future<List<Experience>> getExperiences() async {
    http.Response result = await http.get(Uri.parse('$urlBase$urlKey$urlExperiences'));

    if (result.statusCode == 200) {
      final jsonResponse = json.decode(result.body);
      final experienceMap = jsonResponse['results'];

      List<Experience> experiences = experienceMap.map<Experience>(
          (i) => Experience.fromJson(i)).toList();

      return experiences;
    } else {
      throw Exception('Error al obtener experiencias');
    }
  }

  Future<List<Category>> getCategories() async {
    http.Response result = await http.get(Uri.parse('$urlBase$urlKey$urlCategory'));

    if (result.statusCode == 200) {
      final jsonResponse = json.decode(result.body);
      final categoryMap = jsonResponse['results'];

      List<Category> categories = categoryMap.map<Category>((i) =>
          Category.fromJson(i)).toList();

      return categories;
    }else{
      throw Exception('Error al obtener categorías');
    }
  }

  Future<User> getUser(String id) async {
    http.Response result = await http.get(Uri.parse('$urlBase$urlKey$urlUsers$id'));

    if (result.statusCode == 200) {
      final jsonResponse = json.decode(result.body);
      return User.fromJson(jsonResponse);
    } else {
      throw Exception('Error al obtener usuario');
    }
  }

  Future<List<Tourist>> getTourist(String id) async{
    http.Response result = await http.get(Uri.parse('$urlBase$urlKey$urlTourist$id'));

    if (result.statusCode == 200) {
      final jsonResponse = json.decode(result.body);
      final touristMap = jsonResponse['results'];

      List<Tourist> tourists = touristMap.map<Tourist>((i) => Tourist.fromJson(i)).toList();

      return tourists;
    }else{
      throw Exception('Error al obtener turistas');
    }
  }

}