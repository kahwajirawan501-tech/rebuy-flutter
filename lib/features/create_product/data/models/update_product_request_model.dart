import 'package:roasters/features/create_product/data/models/contact_model.dart';
import 'package:roasters/features/create_product/data/models/price_model.dart';

class UpdateProductRequestModel {
  final String? description;
  final PriceModel? price;
  final int? provinceId;
  final String? addressText;
  final int? typeId;
  final List<String>? images;
  final List<ContactModel>? contacts;

  UpdateProductRequestModel({
    this.description,
    this.price,
    this.provinceId,
    this.addressText,
    this.typeId,
    this.images,
    this.contacts,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (description != null) data['description'] = description;
    if (price != null) {
      data['price'] = {
        "price": price!.price,
        "type": price!.type,
      };
    }
    if (provinceId != null) data['province_id'] = provinceId;
    if (addressText != null) data['address_text'] = addressText;
    if (typeId != null) data['type_id'] = typeId;
    if (images != null) data['images'] = images;
    if (contacts != null) {
      data['contacts'] = contacts!
          .map((e) => {
        "type": e.type,
        "number": e.number,
      })
          .toList();
    }

    return data;
  }
}