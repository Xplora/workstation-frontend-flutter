import 'package:flutter/material.dart';
import 'package:trip_match/baseScaffold.dart';
import 'package:trip_match/IAM/services/authSession.dart';
import 'package:trip_match/models/tourist.dart';
import 'package:trip_match/models/user.dart';
import '../utils/http_helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final HttpHelper _httpHelper = HttpHelper();

  String? userId;
  User? userData;
  Tourist? touristData;
  bool loading = true;    // Controla carga de datos

  Future<void> loadSessionData() async {
    try {
      userId = await AuthSession.getUserId();        // ← SE GUARDA USERID PARA USO GLOBAL

      if(userId == null || userId!.isEmpty) {
        throw "No existe sesión activa";
      }

      userData = await _httpHelper.getUser(userId!);
      touristData = await _httpHelper.getTourist(userId!);

      setState(() => loading = false);

    } catch (e) {
      print("Error al cargar perfil => $e");
      setState(() => loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    loadSessionData();  // ← Igual que tu ejemplo
  }

  @override
  Widget build(BuildContext context) {

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (userData == null || touristData == null) {
      return const Center(child: Text("No se pudo obtener perfil del usuario"));
    }

    final firstName = userData?.firstName ?? "N/A";
    final lastName = userData?.lastName ?? "";
    final email = userData?.email ?? "N/A";
    final phone = userData?.phone ?? "N/A";
    final imageUrl = touristData?.avatarUrl ?? "https://placehold.co/80x80";

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          width: 280,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(imageUrl),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC5EFE9),
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                ),
                child: const Text("Editar"),
              ),
              const SizedBox(height: 10),
              Text("$firstName $lastName",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Correo: $email", style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 4),
              Text("Número: $phone", style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
