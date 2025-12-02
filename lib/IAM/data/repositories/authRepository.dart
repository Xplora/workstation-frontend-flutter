import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/authenticatedUserModel.dart';
import '../models/loginRequest.dart';
import '../models/registerRequest.dart';

class AuthRepository {
  static const String baseUrl = "https://xplora-backend.onrender.com/api/v1/iam/auth";

  Future<AuthenticatedUserModel?> login(LoginRequest request) async {
    print("$baseUrl/signin");
    final url = Uri.parse("$baseUrl/signin");

    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return AuthenticatedUserModel.fromJson(data);
    }

    return null;
  }

  Future<bool> register(RegisterRequest request) async {
    print("$baseUrl/signup");
    final url = Uri.parse("$baseUrl/signup");

    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    return res.statusCode == 201;
  }
}
