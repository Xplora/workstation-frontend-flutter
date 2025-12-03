class Include {
  String? description;

  Include({this.description});

  factory Include.fromJson(Map<String, dynamic> json) {
    return Include(
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
    };
  }
}
