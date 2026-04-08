class SellerModel {
  final int id;
  final String name;
  final String email;
  final String? profileImage;
  final String phone;

  SellerModel({required this.id, required this.name, required this.email,
    required this.profileImage, required this.phone});
  factory SellerModel.fromJson(Map<String, dynamic> json) {
    return SellerModel(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      profileImage:  json['profile_image']
    );
  }
}