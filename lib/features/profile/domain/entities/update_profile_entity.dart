class UpdateProfileEntity {
  final String? name;
  final String? phone;

  final String? image;

  UpdateProfileEntity({required this.name, required this.phone, required this.image});
  UpdateProfileEntity copyWith({
    String?name,
    String?phone,
    String?image
}){
    return UpdateProfileEntity(name: name??this.name, phone: phone??this.phone, image: image??this.image);

}
}