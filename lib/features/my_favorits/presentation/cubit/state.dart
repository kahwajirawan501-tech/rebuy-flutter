
import 'package:roasters/features/my_favorits/domain/entities/favorite_entity.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}
class FavoriteLoading extends FavoriteState {}
class FavoriteSuccess extends FavoriteState {
  final String message;
final List<FavoriteEntity>favorite;

  FavoriteSuccess(this.message, {required this.favorite});
}
class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError(this.message);
}
class FavoriteEmpty extends FavoriteState {
  final String message;
  FavoriteEmpty(this.message);
}
class AddRemoveFavoriteError extends FavoriteState {
  final String message;
  AddRemoveFavoriteError(this.message);
}