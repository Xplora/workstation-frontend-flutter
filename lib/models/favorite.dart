class Favorite {
  int? id;
  String? touristId;
  int? experienceId;

  Favorite({
    this.id,
    this.touristId,
    this.experienceId,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      touristId: json['touristId'],
      experienceId: json['experienceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "touristId": touristId,
      "experienceId": experienceId,
    };
  }
}
