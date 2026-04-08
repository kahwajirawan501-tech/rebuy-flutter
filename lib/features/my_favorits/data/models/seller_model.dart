class SellerFavoriteModel {
  final int id;
  final String name;
  final String email;
  final String? profileImage;
  final String phone;

  SellerFavoriteModel({required this.id, required this.name, required this.email,
    required this.profileImage, required this.phone});
  factory SellerFavoriteModel.fromJson(Map<String, dynamic> json) {
    return SellerFavoriteModel(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      profileImage:  json['profile_image']?? " "
    );
  }
}