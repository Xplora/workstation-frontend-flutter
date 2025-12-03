import 'package:flutter/material.dart';
import 'package:trip_match/baseScaffold.dart';
import 'package:trip_match/UI/searchpanel.dart';
import 'package:trip_match/models/experience.dart';
import 'package:trip_match/models/category.dart';
import 'package:trip_match/models/user.dart';
import 'package:trip_match/services/favoritesService.dart';
import 'package:trip_match/utils/http_helper.dart';

import '../IAM/services/authSession.dart';
import '../models/tourist.dart';

class HomePanel extends StatefulWidget {
  @override
  State<HomePanel> createState() => _HomePanelState();
}

class _HomePanelState extends State<HomePanel> {
  String? token;
  String? userId;
  bool loading = true;

  String nickname = "";
  User? currentUser;

  String? selectedPlace;
  String? selectedCategory;


  final TextEditingController expController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  List<Experience> recommendationsExp = [];
  List<Category> categories = [];

  int? expCount;
  int? catCount;
  bool isLoading = true;
  HttpHelper? helper;

  Future<void> loadSessionData() async {
    token = await AuthSession.getToken();
    userId = await AuthSession.getUserId();
    currentUser = await helper!.getUser(userId!);
    nickname = currentUser!.firstName!;
    categories = await helper!.getCategories();
    recommendationsExp = await helper!.getExperiences();
    await loadFavoritesFromDB(userId!);

    print("CATEGORÍAS CARGADAS: ${categories.length}");
    print("EXPERIENCIAS CARGADAS: ${recommendationsExp.length}");

    setState(() {
      loading = false;
    });
  }


  @override
  void initState(){
    super.initState();
    helper = HttpHelper();
    loadSessionData();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title & Subtitle
            Text(
              "Hola, $nickname",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "Encontremos tu próxima experiencia única",
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(height: 20),

            //Search Campus - Destino
            DropdownButtonFormField<String>(
              value: selectedPlace,
              decoration: InputDecoration(
                labelText: "Destino",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              ),
              items: const[
                DropdownMenuItem(value: "Lima", child: Text("Lima")),
                DropdownMenuItem(value: "Arequipa", child: Text("Arequipa")),
                DropdownMenuItem(value: "Trujillo", child: Text("Trujillo")),
                DropdownMenuItem(value: "Chiclayo", child: Text("Chiclayo")),
                DropdownMenuItem(value: "Ica", child: Text("Ica")),
                DropdownMenuItem(value: "Piura", child: Text("Piura")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedPlace = value;
                });
              },
            ),
            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Día",
                      hintText: "Día",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                        locale: const Locale('es', 'ES'),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                        setState(() {
                          dateController.text = formattedDate;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Presupuesto",
                        hintText: "Presupuesto",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      )
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),

            TextFormField(
              controller: expController,
              decoration: InputDecoration(
                labelText: "Tipo de experiencia",
                hintText: "Tipo de experiencia",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2EBFAF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: (){
                    final place = selectedPlace ?? "Arequipa";
                    final price = priceController.text.isEmpty ? "Max. 1200" : priceController.text;
                    final date = dateController.text;
                    final exp = expController.text;

                    /*Navigator.push(
                        context,
                      MaterialPageRoute(
                            builder: (BuildContext context) => SearchPanel(
                                place: place,
                                price: price,
                                date: date,
                                exp: exp,
                            ),
                        ),
                    );*/
                  },
                  child: const Text(
                    "Buscar",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  )
              ),
            ),
            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (var cat in categories)
                  _buildFilterChip(cat.name!.toString()),
              ],
            ),
            const SizedBox(height: 25),

            // Recomendaciones para ti
            const Text(
              "Recomendaciones para ti",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            ...recommendationsExp.map((expr) => _buildRecommendationCard(expr)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
          expController.text = label;
        });
      },
      child: Chip(
        label: Text(label),
        backgroundColor: selectedCategory == label
            ? const Color(0xFF2EBFAF)
            : const Color(0xFFE6F4F2),
        labelStyle: TextStyle(
          color: selectedCategory == label ? Colors.white : const Color(0xFF2EBFAF),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(Experience exp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // 1. Imagen con el icono de Corazón Superpuesto
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  topRight: Radius.circular(12), // Añadido para la segunda imagen
                  bottomRight: Radius.circular(12), // Añadido para la segunda imagen
                ),
                child: Image.network(
                  exp.experienceImages![0].url.toString(),
                  width: 100, // Aumentado el ancho ligeramente para parecerse más
                  height: 100, // Aumentado el alto ligeramente para parecerse más
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image, color: Colors.grey),
                    );
                  },
                ),
              ),
              // Icono de Corazón Superpuesto (similar a la segunda imagen)
              Positioned(
                top: 8,
                left: 8,
                child: ValueListenableBuilder<Set<String>>(
                  valueListenable: favoritesNotifier,
                  builder: (context, favIds, _) {
                    final isFavorite = favIds.contains(exp.id.toString());
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                          size: 20,
                        ),
                        onPressed: () async {
                          await toggleFavoriteById(exp.id.toString(), userId.toString());
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12), // Ajuste de padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    exp.title.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '10:00am | 2:00pm',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    '${exp.duration.toString()} horas',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. Precio
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              'S/${exp.price}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2EBFAF),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

