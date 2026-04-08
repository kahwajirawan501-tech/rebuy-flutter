class TypesModel{
  final int id;
  final String name;

  TypesModel({required this.id, required this.name});
  factory TypesModel.fromJson(Map<String, dynamic> json){
    return TypesModel(
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