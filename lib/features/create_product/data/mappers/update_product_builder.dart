import 'package:roasters/features/create_product/domain/entities/contact_entity.dart';
import 'package:roasters/features/create_product/domain/entities/price_entity.dart';
import 'package:roasters/features/create_product/domain/entities/update_produc_entity.dart';
import 'package:roasters/features/create_product/presentation/cubit/state.dart';
import 'package:roasters/features/my_product/domain/entities/product_my_product_entity.dart';

class UpdateProductBuilder {
  static UpdateProductEntity build({

    required ProductMyProductEntity old,
    required CreateProductFormState current,
    required List<String> imagePaths,
  }) {
    return UpdateProductEntity(

      description:
      current.description != old.description ? current.description : null,

      price: _isPriceChanged(current.price, old.price)
          ? current.price
          : null,

      provinceId:
      current.provinceId != old.province.id ? current.provinceId : null,

      addressText:
      current.address != old.addressText ? current.address : null,

      typeId: current.typeId != old.type.id ? current.typeId : null,

      images: !_compareImages(imagePaths, old.images)
          ? imagePaths
          : null,

      contacts: !_compareContacts(current.contacts, old.contacts)
          ? current.contacts
          : null,
    );
  }

  /// ===== Helpers =====

  static bool _isPriceChanged(PriceEntity? newPrice, oldPrice) {
    if (newPrice == null && oldPrice == null) return false;
    if (newPrice == null || oldPrice == null) return true;

    return newPrice.price != oldPrice.price ||
        newPrice.type != oldPrice.type;
  }

  static bool _compareImages(List<String> newList, List oldList) {
    final oldPaths = oldList.map((e) => e.imageUrl).toList();
    if (newList.length != oldPaths.length) return false;

    for (int i = 0; i < newList.length; i++) {
      if (newList[i] != oldPaths[i]) return false;
    }
    return true;
  }

  static bool _compareContacts(List<ContactEntity> newList, List oldList) {
    if (newList.length != oldList.length) return false;

    for (int i = 0; i < newList.length; i++) {
      if (newList[i].number != oldList[i].number ||
          newList[i].type != oldList[i].type) {
        return false;
      }
    }
    return true;
  }
}