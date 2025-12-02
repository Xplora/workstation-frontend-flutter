class Experience {
   String? id;
   String? title;
   String? location;
   String? description;
   String? imageUrl;
   double? price;
   String? startTime;
   String? endTime;
   String? duration;
   List<String>? daysAvailable;
   String? category;
   String? provider;
   List<String>? includes;
   bool? isFavorite;

  Experience({
     this.id,
     this.title,
     this.location,
     this.description,
     this.imageUrl,
     this.price,
     this.startTime,
     this.endTime,
     this.duration,
     this.daysAvailable,
     this.category,
     this.provider,
     this.includes,
    this.isFavorite
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

  Experience.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    location = json['location'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    price = json['price'].toDouble();
    startTime = json['startTime'];
    endTime = json['endTime'];
    duration = json['duration'];
    daysAvailable = json['daysAvailable'];
    category = json['category'];
    provider = json['provider'];
    includes = json['includes'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['location'] = this.location;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['price'] = this.price;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['duration'] = this.duration;
    data['daysAvailable'] = this.daysAvailable;
    data['category'] = this.category;
    data['provider'] = this.provider;
    data['includes'] = this.includes;
    data['isFavorite'] = this.isFavorite;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
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
