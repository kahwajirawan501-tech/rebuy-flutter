import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:roasters/core/network/dio_exception_extension.dart';
import 'package:roasters/features/shared_types_provinces/data/models/provinces_model.dart';
import 'package:roasters/features/shared_types_provinces/data/models/types_model.dart';

abstract class SharedRemoteDataSources {
  Future<List<TypesModel>>getTypes();
  Future<List<ProvincesModel>>getProvinces();

}
class SharedRemoteDataSourcesImpl implements SharedRemoteDataSources{
  final Dio dio;

  SharedRemoteDataSourcesImpl(this.dio);
  @override
  Future<List<ProvincesModel>> getProvinces()async {
   try{
     final response = await dio.get(
       '/provinces'
     );
     final List data = response.data['data']['provinces'] as List;
     return data.map((e) => ProvincesModel.fromJson(e)).toList();
   }on DioException catch (e) {
     throw Exception(e.friendlyMessage);
   }
  }

  @override
  Future<List<TypesModel>> getTypes() async{
  try{
    final response = await dio.get(
        '/type'
    );
    final List data = response.data['data']['types'] as List;
    return data.map((e)=>TypesModel.fromJson(e)).toList();
  }on DioException catch(e){
    throw Exception(e.friendlyMessage);
  }
  }

}