class UserModel {
  String? id;
  String name;
  String email;
  String mobileNumber;
  String city;
  String profilePic;
  bool isActive;
  bool isOnline;

  UserModel(
      {required this.name,
      required this.email,
      this.id,
      required this.city,
      required this.mobileNumber,
      this.isActive = true,
      this.isOnline = false,
      this.profilePic = ""});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      email: json["email"],
      id: json["id"],
      mobileNumber: json["mobileNumber"],
      city: json["city"],
      isActive: json["isActive"],
      isOnline: json["isOnline"],
      profilePic: json["profilePic"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "id": id,
      "city": city,
      "mobileNumber": mobileNumber,
      "isActive": isActive,
      "isOnline": isOnline,
      "profilePic": profilePic
    };
  }
}
