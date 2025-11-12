import 'package:flutter/material.dart';

class SearchPanel extends StatelessWidget {
  const SearchPanel({super.key, required this.place, required this.price, required this.date, required this.exp});
  final String place, price, date, exp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF2EBFAF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.3),
                          child: MaterialButton(
                            child: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.3),
                          child: const Icon(Icons.notifications_none, color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),

                    Align(
                      alignment: Alignment.center, //para que este mas al medio las palabras
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxWidth: 1200
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildField("Destino", "${place}"),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                                child: _buildField("Fecha", "${date}")
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    Align(
                      alignment: Alignment.center,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxWidth: 1200
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildField("Precio", "${price}"),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                                child: _buildField("Experiencia", "${exp}")
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),

              Expanded(
                  child: Center(
                    child: Text(
                        "results" //cambiar esto
                    ),
                  )
              )
            ],
          )
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Container(
              width: 700, //ancho fijo de los campos
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                value,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
