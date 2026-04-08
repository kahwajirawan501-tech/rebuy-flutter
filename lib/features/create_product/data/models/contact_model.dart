class ContactModel {
  final String type;
  final String number;

  ContactModel({required this.type, required this.number});
  factory ContactModel.fromJson(Map<String, dynamic> json){
    return ContactModel(
        type: json['type'],
        number: json['number']);
  }
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "number": number,
    };
  }
}