

class UpdateProfileRequestModel {
  final String? name;
  final String? phone;

  final String? images;

  UpdateProfileRequestModel({required this.name, required this.phone, required this.images});




  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (name != null) data['name'] = name;

    data['profile_image'] = images;
    if (phone != null) data['phone'] = phone;


    return data;
  }
}