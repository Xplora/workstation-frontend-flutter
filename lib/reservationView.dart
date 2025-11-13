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
  final TextEditingController dateController = TextEditingController(text: "20/06/2025");
  final TextEditingController peopleController = TextEditingController(text: "1");
  final TextEditingController scheduleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ubicación con mapa
              const Text(
                "Ubicación",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
                      // Simulación de mapa - usar google_maps_flutter en producción
                      Container(
                        color: Colors.grey.shade200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.map, size: 50, color: Colors.grey.shade400),
                              const SizedBox(height: 10),
                              Text(
                                widget.experience.location,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Marcadores simulados
                      Positioned(
                        top: 40,
                        left: 80,
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        right: 100,
                        child: Icon(
                          Icons.location_pin,
                          color: const Color(0xFF2EBFAF),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Horarios y Frecuencia
              const Text(
                "Horarios y Frecuencia",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Frecuencia: ${widget.experience.daysAvailable.join(', ')}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Horarios: **${widget.experience.startTime}** y **${widget.experience.endTime}**",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Duración total: ${widget.experience.duration}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 25),

              // Reservas
              const Text(
                "Reservas",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              // Fecha
              const Text(
                "Fecha",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
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
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: peopleController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                ),
              ),
              const SizedBox(height: 15),

              // Horario
              const Text(
                "Horario",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: scheduleController,
                decoration: InputDecoration(
                  hintText: "Selecciona un horario",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                ),
              ),
              const SizedBox(height: 25),

              // Total a pagar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total a pagar",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "S/${widget.experience.price.toInt()}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2EBFAF),
                    ),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    final item = ItineraryItem(
                      id: '${DateTime.now().millisecondsSinceEpoch}-${widget.experience.id}',
                      experience: widget.experience,
                      date: dateController.text,
                      people: int.tryParse(peopleController.text) ?? 1,
                      totalPrice: widget.experience.price, // puedes multiplicar por personas si aplica
                      schedule: scheduleController.text.isEmpty ? widget.experience.startTime : scheduleController.text,
                    );
                    addItineraryItem(item);
                    _showReservationConfirmation(context);
                  },
                  child: const Text(
                    'Realizar consulta',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showReservationConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            '¡Reserva exitosa!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2EBFAF),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Experiencia: ${widget.experience.title}'),
              const SizedBox(height: 10),
              Text('Fecha: ${dateController.text}'),
              Text('Personas: ${peopleController.text}'),
              const SizedBox(height: 10),
              Text(
                'Total: S/${widget.experience.price.toInt()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Aceptar',
                style: TextStyle(
                  color: Color(0xFF2EBFAF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
