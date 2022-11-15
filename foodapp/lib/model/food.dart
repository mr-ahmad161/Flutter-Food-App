class Food {
    Food({
        required this.id,
       required this.foodName,
       required this.v,
    });

    String id;
    String foodName;
    int v;

    factory Food.fromJson(Map<String, dynamic> json) => Food(
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
