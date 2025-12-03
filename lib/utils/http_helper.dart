import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trip_match/IAM/services/authSession.dart';
import 'package:trip_match/models/tourist.dart';
import '../models/category.dart';
import '../models/experience.dart';
import '../models/user.dart';

class HttpHelper {
  final String urlBase = 'http://localhost:5260/';
  final String urlKey = 'api/v1/';
  final String urlExperiences = 'design/experience';
  final String urlCategory = 'design/category';
  final String urlUsers = 'profile/user/';
  final String urlTourist = 'profile/user/tourist/';

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