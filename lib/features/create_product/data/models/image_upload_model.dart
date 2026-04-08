class ImageUploadModel {
  final String originalname;
  final String filename;
  final String path;

  ImageUploadModel({required this.originalname, required this.filename, required this.path});
  factory ImageUploadModel.fromJson(Map<String, dynamic> json){
    return ImageUploadModel(
        originalname: json['originalname'],
        filename: json['filename'],
        path: json['path'],
    );
  }
}