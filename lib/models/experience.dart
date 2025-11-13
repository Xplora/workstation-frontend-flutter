class Experience {
  final String id;
  final String title;
  final String location;
  final String description;
  final String imageUrl;
  final double price;
  final String startTime;
  final String endTime;
  final String duration;
  final List<String> daysAvailable;
  final String category;
  final String provider;
  final List<String> includes;
  final bool isFavorite;

  Experience({
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.daysAvailable,
    required this.category,
    required this.provider,
    required this.includes,
    this.isFavorite = false,
  });

  Experience copyWith({bool? isFavorite}) {
    return Experience(
      id: id,
      title: title,
      location: location,
      description: description,
      imageUrl: imageUrl,
      price: price,
      startTime: startTime,
      endTime: endTime,
      duration: duration,
      daysAvailable: daysAvailable,
      category: category,
      provider: provider,
      includes: includes,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

// Datos mockeados
class MockData {
  static List<Experience> getExperiences() {
    return [
      Experience(
        id: '1',
        title: 'City Tour Arequipa',
        location: 'Arequipa',
        description:
            'Descubre la belleza colonial de Arequipa en este recorrido guiado por el Centro Histórico, el Mirador de Yanahuara, y el Monasterio de Santa Catalina.',
        imageUrl: 'https://images.unsplash.com/photo-1589394815804-964ed0be2eb5?w=800',
        price: 80,
        startTime: '10:00am',
        endTime: '2:00pm',
        duration: '2 horas',
        daysAvailable: ['Todos los días'],
        category: 'Aventura',
        provider: 'Andes Explorer',
        includes: [
          'Guía profesional certificado.',
          'Tour en Buggy 4x4 (1 hora).',
          'Ticket de ingreso a las Dunas.',
        ],
        isFavorite: false,
      ),
      Experience(
        id: '2',
        title: 'City Tour Arequipa',
        location: 'Arequipa',
        description:
            'Explora los lugares más emblemáticos de la ciudad blanca con guías expertos.',
        imageUrl: 'https://images.unsplash.com/photo-1589394815804-964ed0be2eb5?w=800',
        price: 80,
        startTime: '10:00am',
        endTime: '2:00pm',
        duration: '2 horas',
        daysAvailable: ['Lunes', 'Miércoles', 'Viernes'],
        category: 'Cultura',
        provider: 'Andes Explorer',
        includes: [
          'Guía profesional certificado.',
          'Transporte turístico.',
          'Entradas a museos.',
        ],
        isFavorite: false,
      ),
      Experience(
        id: '3',
        title: 'Tour Cañón del Colca',
        location: 'Arequipa',
        description:
            'Visita uno de los cañones más profundos del mundo y observa el majestuoso vuelo del cóndor.',
        imageUrl: 'https://images.unsplash.com/photo-1587595431973-160d0d94add1?w=800',
        price: 120,
        startTime: '6:00am',
        endTime: '6:00pm',
        duration: '12 horas',
        daysAvailable: ['Todos los días'],
        category: 'Aventura',
        provider: 'Colca Adventures',
        includes: [
          'Transporte completo.',
          'Desayuno y almuerzo.',
          'Guía bilingüe.',
        ],
        isFavorite: false,
      ),
    ];
  }
}
