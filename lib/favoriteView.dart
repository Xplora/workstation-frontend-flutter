import 'package:flutter/material.dart';
import 'package:trip_match/baseScaffold.dart';
import 'package:trip_match/models/experience.dart';
import 'package:trip_match/experienceDetailView.dart';
import 'package:trip_match/services/favoritesService.dart';

class FavoriteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 1,
      body: ValueListenableBuilder<Set<String>>(
        valueListenable: favoritesNotifier,
        builder: (context, favIds, _) {
          final list = MockData.getExperiences().where((e) => favIds.contains(e.id)).toList();
          if (list.isEmpty) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text("Mis Favoritos", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                Center(child: Text('No hay favoritos')),
              ]),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Mis Favoritos", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final exp = list[index];
                  return ListTile(
                    leading: Image.network(exp.imageUrl, width: 56, height: 56, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: 56, height: 56, color: Colors.grey.shade300)),
                    title: Text(exp.title),
                    subtitle: Text(exp.location),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExperienceDetailView(experience: exp))),
                    trailing: IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: () => toggleFavoriteById(exp.id)),
                  );
                },
              ),
            ]),
          );
        },
      ),
    );
  }
}
