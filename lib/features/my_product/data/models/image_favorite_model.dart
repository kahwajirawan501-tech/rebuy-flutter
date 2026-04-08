class ImageMyProductModel {
  final int id;
  final String imageUrl;

  ImageMyProductModel({
    required this.id,
    required this.imageUrl,
  });

  factory ImageMyProductModel.fromJson(Map<String, dynamic> json) {
    return ImageMyProductModel(
      id: json['id'],
      imageUrl: json['image_url'],
    );
  }
}