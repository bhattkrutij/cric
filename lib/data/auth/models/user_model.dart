class UserModel {
  final String id;
  final String email;
  final String image;
  final String token;

  UserModel({
    required this.id,
    required this.email,
    required this.image,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"],
      email: json["email"],
      image: json["image"] ?? "",
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "image": image,
      "token": token,
    };
  }
}
