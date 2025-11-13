import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trip_match/baseScaffold.dart';
import 'package:trip_match/services/itineraryService.dart';

class ItineraryPage extends StatefulWidget {
  const ItineraryPage({super.key});

  @override
  State<ItineraryPage> createState() => _ItineraryPageState();
}

class _ItineraryPageState extends State<ItineraryPage> {
  bool isListView = true;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return BaseScaffold(
      currentIndex: 2,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Mis Itinerarios",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Buscar itinerario",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => isListView = true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      isListView ? const Color(0xFF2EBFAF) : Colors.white,
                      foregroundColor: isListView ? Colors.white : Colors.black,
                      side: const BorderSide(color: Color(0xFF2EBFAF)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Lista"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => isListView = false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      !isListView ? const Color(0xFF2EBFAF) : Colors.white,
                      foregroundColor: !isListView ? Colors.white : Colors.black,
                      side: const BorderSide(color: Color(0xFF2EBFAF)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Calendario"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            isListView ? _buildListView() : _buildCalendarView(),
            if (!isListView && _selectedDay != null) ...[
              const SizedBox(height: 20),
              Text(
                "Fecha seleccionada: ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2EBFAF),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    //return const Center(
    //  child: Text("Aquí se mostrarán los itinerarios en lista."),
    //);
    return ValueListenableBuilder<List<ItineraryItem>>(
      valueListenable: itineraryNotifier,
      builder: (context, items, _) {
        if (items.isEmpty) {
          return const Center(child: Text('No hay reservas aún'));
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, i) {
            final it = items[i];
            return ListTile(
              leading: Image.network(
                it.experience.imageUrl,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(width: 56, height: 56, color: Colors.grey.shade300),
              ),
              title: Text(it.experience.title),
              subtitle: Text('Fecha: ${it.date} • Personas: ${it.people}'),
              trailing: Text('S/${it.totalPrice.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold)),
            );
          },
        );
      },
    );
  }

  Widget _buildCalendarView() {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarFormat: CalendarFormat.month,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Color(0xFF2EBFAF),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Color(0xFF1C867B),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
