import 'package:flutter/material.dart';
import 'package:trip_match/baseScaffold.dart';

class FavoriteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 1,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Mis Favoritos",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
            ),
          ],
        )
      ),
    );
  }
}
