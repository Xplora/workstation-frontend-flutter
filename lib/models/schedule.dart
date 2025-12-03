class Schedule {
  String? time;

  Schedule({this.time});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "time": time,
    };
  }
}
