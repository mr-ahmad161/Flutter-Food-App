class GetUser {
    GetUser({
       required this.id,
       required this.fullName,
       required this.email,
      required  this.password,
      required  this.role,
      required  this.v,
    });

    String id;
    String fullName;
    String email;
    String password;
    String role;
    int v;

    factory GetUser.fromJson(Map<String, dynamic> json) => GetUser(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "email": email,
        "password": password,
        "role": role,
        "__v": v,
    };
}
