import 'package:flutter/material.dart';
import 'package:trip_match/models/experience.dart';
import 'package:trip_match/reservationView.dart';
import 'package:trip_match/services/favoritesService.dart';

class ExperienceDetailView extends StatefulWidget {
  final Experience experience;

  const ExperienceDetailView({super.key, required this.experience});

  @override
  State<ExperienceDetailView> createState() => _ExperienceDetailViewState();
}

class _ExperienceDetailViewState extends State<ExperienceDetailView> {
  //bool isFavorite = false;

  //@override
  //void initState() {
  //  super.initState();
  //  isFavorite = widget.experience.isFavorite;
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen principal
                Stack(
                  children: [
                    Image.network(
                      widget.experience.imageUrl,
                      width: double.infinity,
                      height: 280,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 280,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image, size: 80, color: Colors.grey),
                        );
                      },
                    ),
                    Positioned(
                      top: 40,
                      left: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        child: ValueListenableBuilder<Set<String>>(
                            valueListenable: favoritesNotifier,
                            builder: (context, favIds, _) {
                              final isFavorite = favIds.contains(widget.experience.id);
                              return IconButton(
                                icon: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.black,
                                ),
                                onPressed: () {
                                  toggleFavoriteById(widget.experience.id);
                                },
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),

                // Contenido
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título
                      Text(
                        widget.experience.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.experience.location,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Por empresa
                      Row(
                        children: [
                          const Icon(
                            Icons.storefront,
                            size: 18,
                            color: Color(0xFF2EBFAF),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Por ${widget.experience.provider}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF2EBFAF),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Color(0xFF2EBFAF),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Descripción
                      const Text(
                        "Descripción",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.experience.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Qué incluye
                      const Text(
                        "Qué incluye",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...widget.experience.includes.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "• ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Botón flotante de reserva
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'S/${widget.experience.price.toInt()}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2EBFAF),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReservationView(experience: widget.experience),
                          ),
                        );
                      },
                      child: const Text(
                        'Reserva',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
