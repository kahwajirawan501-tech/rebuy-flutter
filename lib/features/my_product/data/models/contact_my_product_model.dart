class ContactMyProductModel {
  final int id;
  final String type;
  final String number;

  ContactMyProductModel({
    required this.id,
    required this.type,
    required this.number,
  });

  factory ContactMyProductModel.fromJson(Map<String, dynamic> json) {
    return ContactMyProductModel(
      id: json['id'],
      type: json['type'],
      number: json['number'],
    );
  }
}