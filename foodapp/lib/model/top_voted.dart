class Vote {
  Vote({
    required this.message,
    required this.favrt,
  });

  String message;
  Favrt favrt;

  factory Vote.fromJson(Map<String, dynamic> json) => Vote(
        message: json["message"],
        favrt: Favrt.fromJson(json["favrt"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "favrt": favrt.toJson(),
      };
}

class Favrt {
  Favrt({
    required this.id,
    required this.foodName,
    required this.v,
  });

  String id;
  String foodName;
  int v;

  factory Favrt.fromJson(Map<String, dynamic> json) => Favrt(
        id: json["_id"],
        foodName: json["foodName"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "foodName": foodName,
        "__v": v,
      };
}
