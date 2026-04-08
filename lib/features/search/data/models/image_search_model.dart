class ImageSearchModel {
  final int id;
  final String imageUrl;

  ImageSearchModel({
    required this.id,
    required this.imageUrl,
  });

  factory ImageSearchModel.fromJson(Map<String, dynamic> json) {
    return ImageSearchModel(
      id: json['id'],
      imageUrl: json['image_url'],
    );
  }
}