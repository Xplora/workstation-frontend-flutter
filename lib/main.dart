import 'package:flutter/material.dart';
import 'package:trip_match/baseScaffold.dart';
import 'package:trip_match/searchpanel.dart';
import 'package:trip_match/models/experience.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePanel(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
      theme: ThemeData(
        primaryColor: const Color(0xFF2EBFAF),
        fontFamily: 'Poppins',
      ),
    );
  }
}

class HomePanel extends StatefulWidget {
  @override
  State<HomePanel> createState() => _HomePanelState();
}

class _HomePanelState extends State<HomePanel> {
  String? selectedPlace;
  String? selectedCategory;

  final TextEditingController expController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  List<Experience> recommendations = MockData.getExperiences();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title & Subtitle
              const Text(
                "Hola, NickName",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SearchPanel(
                                  place: place,
                                  price: price,
                                  date: date,
                                  exp: exp,
                              ),
                          ),
                      );
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
                children: [
                  _buildFilterChip("Familiar"),
                  _buildFilterChip("Aventura"),
                  _buildFilterChip("Full day"),
                  _buildFilterChip("Cultura"),
                ],
              ),
              const SizedBox(height: 25),

              // Recomendaciones para ti
              const Text(
                "Recomendaciones para ti",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              ...recommendations.map((exp) => _buildRecommendationCard(exp)).toList(),
            ],
          ),
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
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.network(
              exp.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image, color: Colors.grey),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exp.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${exp.startTime} | ${exp.endTime}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    exp.duration,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              'S/${exp.price.toInt()}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2EBFAF),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(
                exp.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: exp.isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                // Toggle favorite
              },
            ),
          ),
        ],
      ),
    );
  }
}


