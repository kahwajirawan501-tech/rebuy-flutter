class UserProfileModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;
  final String role;

  UserProfileModel({required this.id, required this.name, required this.email, required this.phone, required this.profileImage, required this.role});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: int.parse(json['id'].toString()),
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profileImage: json['profile_image'],
      role: json['role'],

    );
  }

}