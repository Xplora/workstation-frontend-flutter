import 'package:flutter/material.dart';
import 'package:trip_match/models/experience.dart';
import 'package:trip_match/services/itineraryService.dart';

class ReservationView extends StatefulWidget {
  final Experience experience;

  const ReservationView({super.key, required this.experience});

  @override
  State<ReservationView> createState() => _ReservationViewState();
}

class _ReservationViewState extends State<ReservationView> {
  final TextEditingController dateController =
  TextEditingController(text: "20/06/2025");
  final TextEditingController peopleController =
  TextEditingController(text: "1");
  final TextEditingController scheduleController = TextEditingController();

  // 1. Variable para almacenar y recalcular el precio total
  double _currentTotalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    // Inicializar el precio total al cargar
    _calculateTotalPrice();

    // 2. Agregar un listener al controlador de personas
    peopleController.addListener(_calculateTotalPrice);
  }

  @override
  void dispose() {
    // 3. Importante: remover el listener y disponer de los controladores
    peopleController.removeListener(_calculateTotalPrice);
    dateController.dispose();
    peopleController.dispose();
    scheduleController.dispose();
    super.dispose();
  }

  // Función para calcular y actualizar el precio total
  void _calculateTotalPrice() {
    final basePrice = widget.experience.price ?? 0.0;
    final peopleCount = int.tryParse(peopleController.text) ?? 1;

    // Se asegura que el conteo de personas sea al menos 1 para el cálculo
    final safePeopleCount = peopleCount < 1 ? 1 : peopleCount;

    final newTotal = basePrice * safePeopleCount;

    // Solo llama a setState si el precio ha cambiado para evitar reconstrucciones innecesarias
    if (_currentTotalPrice != newTotal) {
      setState(() {
        _currentTotalPrice = newTotal;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'TripMatch',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ubicación con mapa simulado
            const Text(
              "Ubicación",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Container(
                      color: Colors.grey.shade200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.map,
                                size: 50, color: Colors.grey.shade400),
                            const SizedBox(height: 10),
                            Text(
                              exp.location ?? "-",
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 40,
                        left: 80,
                        child: Icon(Icons.location_pin,
                            color: Colors.red, size: 30)),
                    Positioned(
                        bottom: 50,
                        right: 100,
                        child: Icon(Icons.location_pin,
                            color: const Color(0xFF2EBFAF), size: 30)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Horarios y frecuencia
            const Text(
              "Horarios y Frecuencia",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Frecuencia: ${exp.frequencies ?? "-"}",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 5),
            Text(
              "Horarios: -",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 5),
            Text(
              "Duración total: ${exp.duration ?? "-"}",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 25),

            // Reservas
            const Text(
              "Reservas",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // Fecha
            const Text(
              "Fecha",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
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
            const SizedBox(height: 15),

            // Número de personas
            const Text(
              "Número de personas",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: peopleController,
              keyboardType: TextInputType.number,
              // Aquí se utiliza el listener añadido en initState
              decoration: InputDecoration(
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              ),
            ),
            const SizedBox(height: 15),

            // Horario
            const Text(
              "Horario",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: scheduleController,
              decoration: InputDecoration(
                hintText: "Selecciona un horario",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              ),
            ),
            const SizedBox(height: 25),

            // Total a pagar - ¡ACTUALIZADO!
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total a pagar",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // Usamos la variable _currentTotalPrice
                Text(
                  "S/${_currentTotalPrice.toInt()}",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2EBFAF)),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Botón Realizar consulta
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2EBFAF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  final peopleCount = int.tryParse(peopleController.text) ?? 1;
                  final totalCalculatedPrice = (exp.price ?? 0) * (peopleCount < 1 ? 1 : peopleCount);

                  final item = ItineraryItem(
                    id:
                    '${DateTime.now().millisecondsSinceEpoch}-${exp.id ?? "0"}',
                    experience: exp,
                    date: dateController.text,
                    people: peopleCount < 1 ? 1 : peopleCount,
                    // Usar el precio recalculado
                    totalPrice: totalCalculatedPrice,
                    schedule: scheduleController.text.isEmpty
                        ? ("")
                        : scheduleController.text,
                  );

                  addItineraryItem(item);
                  _showReservationConfirmation(context, item);
                },
                child: const Text(
                  'Realizar consulta',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showReservationConfirmation(BuildContext context, ItineraryItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text(
            '¡Reserva exitosa!',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF2EBFAF)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Experiencia: ${item.experience.title}'),
              const SizedBox(height: 10),
              Text('Fecha: ${item.date}'),
              Text('Personas: ${item.people}'),
              const SizedBox(height: 10),
              Text(
                'Total: S/${item.totalPrice}',
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Aceptar',
                style: TextStyle(
                    color: Color(0xFF2EBFAF), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}