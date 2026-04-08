class ContactFavoriteModel {
  final int id;
  final String type;
  final String number;

  ContactFavoriteModel({
    required this.id,
    required this.type,
    required this.number,
  });

  factory ContactFavoriteModel.fromJson(Map<String, dynamic> json) {
    return ContactFavoriteModel(
      id: json['id'],
      type: json['type'],
      number: json['number'],
    );
  }
}