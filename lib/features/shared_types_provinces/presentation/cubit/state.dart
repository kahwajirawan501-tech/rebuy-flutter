import 'package:roasters/features/shared_types_provinces/domain/entities/provinces_entity.dart';
import 'package:roasters/features/shared_types_provinces/domain/entities/types_entity.dart';

abstract class SharedState {}

class SharedInitial extends SharedState {}

class SharedLoading extends SharedState {}

class SharedLoaded extends SharedState {
  final List<TypesEntity> types;
  final List<ProvincesEntity> provinces;

  SharedLoaded({required this.types, required this.provinces});
}

class SharedError extends SharedState {
  final String message;
  SharedError(this.message);
}