import 'package:flutter/material.dart';
import 'package:trip_match/models/experience.dart';
import 'package:trip_match/UI/experienceDetailView.dart';
import 'package:trip_match/services/favoritesService.dart';
import 'package:trip_match/utils/http_helper.dart';

import '../IAM/services/authSession.dart';

class SearchPanel extends StatefulWidget {
  const SearchPanel({
    super.key,
    required this.place,
    required this.price,
    required this.date,
    required this.exp,
  });

  final String place, price, date, exp;

  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  List<Experience> experiences = [];
  bool loading = true;
  late HttpHelper helper;
  String? userId;

  @override
  void initState() {
    super.initState();
    helper = HttpHelper();
    initialize();
  }

  Future initialize() async {
    setState(() => loading = true);
    userId = await AuthSession.getUserId();

    try {
      experiences = await helper.searchExperiences(
        lugar: widget.place,
        categoria: widget.exp,
        precio: widget.price,
        fecha: widget.date.isEmpty ? null : widget.date,
      );
    } catch (e) {
      print("Error al cargar experiencias: $e");
    } finally {
      setState(() => loading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _header(), // tu header sigue igual

            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFF2EBFAF)))
                  : experiences.isEmpty
                  ? const Center(
                child: Text(
                  "No se encontraron experiencias",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: experiences.length,
                itemBuilder: (context, index) => _buildExperienceCard(experiences[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  //  HEADER PANEL
  // ─────────────────────────────────────────
  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Color(0xFF2EBFAF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.3),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.3),
                child: const Icon(Icons.notifications_none, color: Colors.white),
              )
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(child: _field("Destino", widget.place)),
              const SizedBox(width: 10),
              Expanded(child: _field("Fecha", widget.date.isEmpty ? "xx/xx/xxxx" : widget.date)),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(child: _field("Presupuesto", widget.price.isEmpty ? "Max. XXX" : widget.price)),
              const SizedBox(width: 10),
              Expanded(child: _field("Experiencia", widget.exp.isEmpty ? "Aventura" : widget.exp)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _field(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(8)),
          child: Text(value, style: const TextStyle(fontSize: 13)),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────
  // CARD EXPERIENCIA
  // ─────────────────────────────────────────
  Widget _buildExperienceCard(Experience exp) {
    return GestureDetector(
      onTap: ()=> Navigator.push(context,MaterialPageRoute(builder: (_)=> ExperienceDetailView(experience: exp, userId: userId!))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow:[
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0,2)
            )
          ],
        ),

        child: Row(
          children: [
            // Imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                (exp.experienceImages != null && exp.experienceImages!.isNotEmpty)
                    ? exp.experienceImages![0].url ?? ''
                    : '',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(
                    exp.title ?? "Sin título",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "-", // horario u otra info
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  Text(
                    exp.duration.toString() ?? "-",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            // Precio y favorito
            Column(
              children: [
                Text(
                  "S/${exp.price?.toInt() ?? 0}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2EBFAF)),
                ),

                ValueListenableBuilder<Set<String>>(
                  valueListenable: favoritesNotifier,
                  builder: (_, ids, __){
                    final selected = ids.contains(exp.id.toString());

                    return IconButton(
                      icon: Icon(selected ? Icons.favorite : Icons.favorite_border,
                          color: selected ? Colors.red : Colors.grey),
                      onPressed: () => toggleFavoriteById(exp.id.toString(), userId!),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }







}
