class User {
  String image;
  String name;
  String email;
  String gender;

  // Constructor
  User({
    required this.image,
    required this.name,
    required this.email,
    required this.gender,
  });

  User copy({
    String? imagePath,
    String? name,
    String? gender,
    String? email,
  }) =>
      User(
        image: imagePath ?? this.image,
        name: name ?? this.name,
        email: email ?? this.email,
        gender: gender ?? this.gender,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        image: json['imagePath'],
        name: json['name'],
        email: json['email'],
        gender: json['gender'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': image,
        'name': name,
        'email': email,
        'phone': gender,
      };
}
