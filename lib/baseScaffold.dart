import 'package:flutter/material.dart';
import 'package:trip_match/itinerarypanel.dart';
import 'package:trip_match/main.dart';
import 'package:trip_match/favoriteView.dart';
import 'package:trip_match/profilePage.dart';

class BaseScaffold extends StatefulWidget {
  final Widget body; // contenido de la página
  final int currentIndex;

  const BaseScaffold({super.key, required this.body, required this.currentIndex});

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  void _onItemTapped(int index) {
    if (index == widget.currentIndex) return; // Evita recargar la misma vista

    Widget page;
    switch (index) {
      case 0:
        page = HomePanel();
        break;
      case 1:
        page = FavoriteView();
        break;
      case 2:
        page = ItineraryPage();
        break;
      case 3:
        page = ProfilePage();
        break;
      default:
        page = HomePanel();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("lib/assets/logo-TripMatch.png"),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "TripMatch",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(child: widget.body),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        selectedItemColor: const Color(0xFF2EBFAF),
        unselectedItemColor: Colors.black54,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_sharp), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.book_rounded), label: 'Itinerarios'),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin_circle_rounded), label: 'Perfil'),
        ],
      ),
    );
  }
}
