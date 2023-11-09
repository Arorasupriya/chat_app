class UserModel {
  String? id;
  String? name;
  String? email;
  String? mobileNumber;
  String? city;

  UserModel({this.name, this.email, this.id, this.city, this.mobileNumber});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      email: json["email"],
      id: json["id"],
      mobileNumber: json["mobileNumber"],
      city: json["city"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "id": id,
      "city": city,
      "mobileNumber": mobileNumber
    };
  }
}
