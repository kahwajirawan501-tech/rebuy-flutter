class ContactSearchModel {
  final int id;
  final String type;
  final String number;

  ContactSearchModel({
    required this.id,
    required this.type,
    required this.number,
  });

  factory ContactSearchModel.fromJson(Map<String, dynamic> json) {
    return ContactSearchModel(
      id: json['id'],
      type: json['type'],
      number: json['number'],
    );
  }
}