class ImageFavoriteModel {
  final int id;
  final String imageUrl;

  ImageFavoriteModel({
    required this.id,
    required this.imageUrl,
  });

  factory ImageFavoriteModel.fromJson(Map<String, dynamic> json) {
    return ImageFavoriteModel(
      id: json['id'],
      imageUrl: json['image_url'],
    );
  }
}