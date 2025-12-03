class ExperienceImage {
  String? url;

  ExperienceImage({this.url});

  factory ExperienceImage.fromJson(Map<String, dynamic> json) {
    return ExperienceImage(
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "url": url,
    };
  }
}
