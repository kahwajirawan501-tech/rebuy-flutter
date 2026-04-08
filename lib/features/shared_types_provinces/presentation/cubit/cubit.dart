import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/features/shared_types_provinces/data/repositories/shared_repository_impl.dart';
import 'package:roasters/features/shared_types_provinces/domain/usecase/get_provinces_usecase.dart';
import 'package:roasters/features/shared_types_provinces/domain/usecase/get_types_usecase.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/state.dart';

class SharedCubit extends Cubit<SharedState> {
  final GetTypesUseCase getTypes;
  final GetProvincesUseCase getProvinces;
  final SharedRepositoryImpl repository; // تحتاج تسجيل impl
  SharedCubit(this.getTypes, this.getProvinces, this.repository)
      : super(SharedInitial());

  Future<void> reloadData() async {
    repository.clearCache();
    await loadSharedData(forceRefresh: true);
  }
  Future<void> loadSharedData({bool forceRefresh = false}) async {
    if (!forceRefresh && state is SharedLoaded) return;

    emit(SharedLoading());

    try {
      final typesData = await getTypes();
      final provincesData = await getProvinces();

      emit(SharedLoaded(
        types: typesData,
        provinces: provincesData,
      ));
    } catch (e) {
      emit(SharedError(e.toString()));
    }
  }

}