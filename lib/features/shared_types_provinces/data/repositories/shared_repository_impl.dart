import 'package:flutter/cupertino.dart';
import 'package:roasters/features/shared_types_provinces/data/datasources/shared_remote_data_sources.dart';
import 'package:roasters/features/shared_types_provinces/data/mappers/provinces_mapper.dart';
import 'package:roasters/features/shared_types_provinces/data/mappers/types_mapper.dart';
import 'package:roasters/features/shared_types_provinces/domain/entities/provinces_entity.dart';
import 'package:roasters/features/shared_types_provinces/domain/entities/types_entity.dart';
import 'package:roasters/features/shared_types_provinces/domain/repositories/shared_repository.dart';

class SharedRepositoryImpl implements SharedRepository {
  final SharedRemoteDataSources sharedRemoteDataSources;

  SharedRepositoryImpl(this.sharedRemoteDataSources);

  List<ProvincesEntity>? _cachedProvinces;
  List<TypesEntity>? _cachedTypes;
  Future<void> clearCache() async{
    _cachedProvinces = null;
    _cachedTypes = null;
  }
  @override
  Future<List<ProvincesEntity>> getProvinces() async {
    if (_cachedProvinces != null) {
      return _cachedProvinces!;
    }

    final models = await sharedRemoteDataSources.getProvinces();
    final entities = models.map((e) => e.toEntity()).toList();

    _cachedProvinces = entities; // خزّن
    return entities;
  }

  @override
  Future<List<TypesEntity>> getTypes() async {
    if (_cachedTypes != null) {
      return _cachedTypes!;
    }

    final models = await sharedRemoteDataSources.getTypes();
    final entities = models.map((e) => e.toEntity()).toList();

    _cachedTypes = entities;
    return entities;
  }
}