import 'package:roasters/features/create_product/data/models/contact_model.dart';
import 'package:roasters/features/create_product/data/models/price_model.dart';

class CreateProductRequestModel {
  String? description;
  int? provinceId;
  String? addressText;
  int? typeId;
  List<String> images = [];
  List<ContactModel> contacts = [];
  PriceModel? price ;
  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "price": price != null ? {"type": price!.type, "price": price!.price} : null,
      "province_id": provinceId,
      "address_text": addressText,
      "type_id": typeId,
      "images": images,
      "contacts": contacts.map((e) => e.toJson()).toList(),
    };
  }
}