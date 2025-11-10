import 'package:flutter/material.dart';
import 'package:trip_match/baseScaffold.dart';
import 'package:trip_match/searchpanel.dart';
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
  int _selectedIndex = 0;

  final TextEditingController expController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      currentIndex: 0,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title & Subtitle
              const Text(
                "Hola",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "Encontremos tu próxima experiencia única",
                style: TextStyle(color: Colors.black54),
              ),

              //Search Campus
              DropdownButtonFormField<String>(
                value: selectedPlace,
                decoration: InputDecoration(
                  labelText: "Destino",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
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
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Fecha",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF2EBFAF)), // ícono de calendario
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
                          // Formatear la fecha seleccionada (dd/mm/yyyy)
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
                      decoration: InputDecoration(
                        labelText: "Precio",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                      )
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: expController,
                decoration: InputDecoration(
                  labelText: "Tipo de experiencia",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
              ),
              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2EBFAF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                    onPressed: (){
                      final place = selectedPlace;
                      final price = priceController.text;
                      final date = dateController.text;
                      final exp = expController.text;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SearchPanel(
                                  place: place!,
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
                        fontSize: 16, color: Colors.white
                      ),
                    )
                ),
              ),
              const SizedBox(height: 15),

              Wrap(
                spacing: 8,
                children: [
                  _buildFilterChip("Familiar"),
                  _buildFilterChip("Aventura"),
                  _buildFilterChip("Full day"),
                  _buildFilterChip("Cultura"),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }


  Widget _buildFilterChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: const Color(0xFFE6F4F2),
      labelStyle: const TextStyle(color: Color(0xFF2EBFAF)),
    );
  }

}


