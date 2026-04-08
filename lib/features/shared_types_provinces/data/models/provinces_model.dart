class ProvincesModel{
  final int id;
  final String name;

  ProvincesModel({required this.id, required this.name});
  factory ProvincesModel.fromJson(Map<String, dynamic> json){
    return ProvincesModel(
        id: json['id'],
        name: json['name']
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}