import 'package:flutter/material.dart';
import 'package:trip_match/models/experience.dart';
import 'package:trip_match/services/favoritesService.dart';
import '../IAM/services/authSession.dart';
import '../utils/http_helper.dart';

class FavoriteView extends StatefulWidget {
  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  String? userId;
  bool loading = true;
  List<Experience> favExperiences = [];
  HttpHelper? helper;

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    loadData();
  }

  Future<void> loadData() async {
    userId = await AuthSession.getUserId();

    if (userId != null) {
      await loadFavoritesFromDB(userId!);
      favExperiences = await helper!.getFavoriteExperiences(userId!);
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Mis Favoritos")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ValueListenableBuilder<Set<String>>(
        valueListenable: favoritesNotifier,
        builder: (context, favIds, _) {

          if (favIds.isEmpty) {
            return const Center(child: Text("No hay favoritos "));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: favExperiences.length,
            itemBuilder: (context, index) {
              final exp = favExperiences[index];

              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    exp.experienceImages?[0].url ?? "",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, error, stack) => Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey.shade300,
                      child: Icon(Icons.image, color: Colors.grey.shade600, size: 24),
                    ),
                    loadingBuilder: (ctx, child, loading) {
                      if (loading == null) return child;
                      return Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey.shade300,
                        child: Icon(Icons.image, color: Colors.grey.shade600, size: 24),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
