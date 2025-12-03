import 'package:flutter/material.dart';
import 'package:trip_match/UI/itinerarypanel.dart';
import 'package:trip_match/UI/favoriteView.dart';
import 'package:trip_match/UI/profilePage.dart';

import 'UI/HomePanel.dart';

class BaseScaffold extends StatefulWidget {
  final Widget body;
  final int currentIndex;

  const BaseScaffold({super.key, required this.body, required this.currentIndex});

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {

  final List<String> _routes = const [
    "/home", // index 0
    "/favorite", // index 1
    "/itineraries", // index 2
    "/profile", // index 3
  ];

  void _onItemTapped(int index) {
    if (index == widget.currentIndex) return;

    Navigator.pushReplacementNamed(
      context,
      _routes[index],
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