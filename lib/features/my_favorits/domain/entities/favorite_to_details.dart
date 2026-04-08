import 'package:roasters/features/my_favorits/domain/entities/product_favorite_entity.dart';
import 'package:roasters/features/search/domain/entities/contact_search_entity.dart';
import 'package:roasters/features/search/domain/entities/price_search_entity.dart';
import 'package:roasters/features/search/domain/entities/product_details_entity.dart';

extension FavoriteToDetails on ProductFavoriteEntity {
  ProductDetailsEntity toDetailsEntity() {
    return ProductDetailsEntity(
      sellerName: user.name ?? "Unknown",
      description: description,
      images: images.map((e) => e.imageUrl ?? "").toList(),
      contacts: contacts.map((c) => ContactSearchEntity(
        type: c.type,
        id: c.id,
        number: c.number
      )).toList(),
      location: province.name ?? "Unknown",
      price: price != null
          ? PriceSearchEntity(id:id,price: price!.price, type: price!.type)
          : null,
      addressText: addressText,
      isSold: isSold,
    );
  }
}