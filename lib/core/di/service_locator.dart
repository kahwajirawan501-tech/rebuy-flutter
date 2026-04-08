import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:roasters/core/network/dio_client.dart';
import 'package:roasters/core/network/network_cubit.dart';
import 'package:roasters/features/auth/data/LocalDataSource/auth_local_data_source.dart';
import 'package:roasters/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:roasters/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:roasters/features/auth/domain/repositories/auth_repository.dart';
import 'package:roasters/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:roasters/features/auth/domain/usecases/login_usecase.dart';
import 'package:roasters/features/auth/domain/usecases/signup_usecase.dart';
import 'package:roasters/features/auth/domain/usecases/verification_uscase.dart';
import 'package:roasters/features/auth/presentation/cubit/login_cubit/cubit.dart';
import 'package:roasters/features/auth/presentation/cubit/signup_cubit/cubit.dart';
import 'package:roasters/features/auth/presentation/cubit/user_cubit/user_cubit.dart';
import 'package:roasters/features/auth/presentation/cubit/verification_cubit/cubit.dart';
import 'package:roasters/features/create_product/data/datasources/create_product_remote_data_source.dart';
import 'package:roasters/features/create_product/data/repositories/create_product_repository_impl.dart';
import 'package:roasters/features/create_product/domain/repositories/create_product_repository.dart';
import 'package:roasters/features/create_product/domain/usecases/create_product_usecase.dart';
import 'package:roasters/features/create_product/domain/usecases/update_product_usecase.dart';
import 'package:roasters/features/create_product/domain/usecases/upload_image_usecase.dart';
import 'package:roasters/features/create_product/presentation/cubit/cubit.dart';
import 'package:roasters/features/my_favorits/data/datasources/favorite_remote_data_sources.dart';
import 'package:roasters/features/my_favorits/data/repositories/favorite_repository_impl.dart';
import 'package:roasters/features/my_favorits/domain/repositories/favorite_repository.dart';
import 'package:roasters/features/my_favorits/domain/usecases/add_favorite_usecase.dart';
import 'package:roasters/features/my_favorits/domain/usecases/get_favorite_usecase.dart';
import 'package:roasters/features/my_favorits/domain/usecases/remove_favorite_usecase.dart';
import 'package:roasters/features/my_favorits/presentation/cubit/cubit.dart';
import 'package:roasters/features/my_product/data/datasources/my_product_remote_data_sources.dart';
import 'package:roasters/features/my_product/data/repositories/my_product_repository_impl.dart';
import 'package:roasters/features/my_product/domain/repositories/my_product_repository.dart';
import 'package:roasters/features/my_product/domain/usecases/get_my_product_usecase.dart';
import 'package:roasters/features/my_product/domain/usecases/remove_product_usecase.dart';
import 'package:roasters/features/my_product/domain/usecases/update_is_sold_usecase.dart';
import 'package:roasters/features/my_product/presentation/cubit/cubit.dart';
import 'package:roasters/features/profile/data/datasources/profile_remote_data_sources.dart';
import 'package:roasters/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:roasters/features/profile/domain/repositories/profile_repository.dart';
import 'package:roasters/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:roasters/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:roasters/features/profile/domain/usecases/upload_image_profile_usecase.dart';
import 'package:roasters/features/profile/presentation/cubit/cubit.dart';
import 'package:roasters/features/profile/presentation/cubit/cubit_languages.dart';
import 'package:roasters/features/search/data/datasources/search_remote_data_sources.dart';
import 'package:roasters/features/search/data/repositories/search_product_repository_impl.dart';
import 'package:roasters/features/search/domain/repositories/search_product_repository.dart';
import 'package:roasters/features/search/domain/usecases/add_favorite_usecase.dart';
import 'package:roasters/features/search/domain/usecases/remove_favorite_usecase.dart';
import 'package:roasters/features/search/domain/usecases/search_product_usecase.dart';
import 'package:roasters/features/search/presentation/cubit/cubit.dart';
import 'package:roasters/features/shared_types_provinces/data/datasources/shared_remote_data_sources.dart';
import 'package:roasters/features/shared_types_provinces/data/repositories/shared_repository_impl.dart';
import 'package:roasters/features/shared_types_provinces/domain/repositories/shared_repository.dart';
import 'package:roasters/features/shared_types_provinces/domain/usecase/get_provinces_usecase.dart';
import 'package:roasters/features/shared_types_provinces/domain/usecase/get_types_usecase.dart';
import 'package:roasters/features/shared_types_provinces/presentation/cubit/cubit.dart';
import 'package:roasters/features/splash/presentation/cubit/cubit.dart';

final sl = GetIt.instance;

Future<void> setup() async {

  //! Local Data Source
  sl.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(const FlutterSecureStorage()),
  );
  //! Core

//! Dio
  sl.registerLazySingleton<Dio>(
        () => DioClient(sl<AuthLocalDataSource>()).dio,
  );
  //! DataSources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl<Dio>()),
  );

  //! Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl<AuthRemoteDataSource>(), sl<AuthLocalDataSource>(),),
  );
////////////////////////////////////////////////////////////////
  //! UseCases  login
  sl.registerLazySingleton(
        () => LoginUseCase(sl<AuthRepository>()),
  );

  //! Cubits login
  sl.registerFactory(
        () => LoginCubit(sl<LoginUseCase>()),
  );
///////////////////////////////////////////////////////////////////
  sl.registerFactory(() => SplashCubit(sl<AuthLocalDataSource>()));
////////////////////////////////////////////////////////////////////
  //! UseCases signup
  sl.registerLazySingleton(
        () => SignupUseCase(sl<AuthRepository>()),
  );

  //! Cubits signup
  sl.registerFactory(
        () => SignUpCubit(sl<SignupUseCase>()),
  );
  //////////////////////////////////////////////////////////////////////////////////
  //! UseCases verification
  sl.registerLazySingleton(
        () => VerificationUsCase(sl<AuthRepository>()),
  );

  //! Cubits
  sl.registerFactory(
        () => VerificationCubit(sl<VerificationUsCase>()),
  );
  //////////////////////////////////////////////////////////////////////////////////

  //! UseCases GetUser
  sl.registerLazySingleton(
        () => GetUserUseCase(sl<AuthRepository>()),
  );
  //! Cubits
  sl.registerFactory(
        () => UserCubit(sl<GetUserUseCase>()),
  );
  /////////////////////////////////////////////////////////////////////
  sl.registerLazySingleton<SharedRemoteDataSources>(
        () => SharedRemoteDataSourcesImpl(sl<Dio>()),
  );

  sl.registerLazySingleton<SharedRepositoryImpl>(
          () => SharedRepositoryImpl(sl<SharedRemoteDataSources>()));

  sl.registerLazySingleton<SharedRepository>(
        () => sl<SharedRepositoryImpl>(),
  );

  sl.registerLazySingleton(
        () => GetTypesUseCase(sl<SharedRepository>()),
  );
  sl.registerLazySingleton(
        () => GetProvincesUseCase(sl<SharedRepository>()),
  );

  sl.registerLazySingleton<SharedCubit>(
        () => SharedCubit(sl<GetTypesUseCase>(), sl<GetProvincesUseCase>(),sl<SharedRepositoryImpl>()),
  );
  ///////////////////////////////////////
  sl.registerLazySingleton<CreateProductRemoteDataSource>(
        () => CreateProductRemoteDataSourceImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<CreateProductRepository>(
        () => CreateProductRepositoryImpl(sl<CreateProductRemoteDataSource>()),
  );
  sl.registerLazySingleton(
        () => CreateProductUseCase(sl<CreateProductRepository>()),
  );
  sl.registerLazySingleton(
        () => UploadImageUseCase(sl<CreateProductRepository>()),
  );
  sl.registerLazySingleton(
        () => UpdateProductUseCase(sl<CreateProductRepository>()),
  );
  sl.registerFactory<CreateProductCubit>(
        () => CreateProductCubit(sl<CreateProductUseCase>(),
            sl<UploadImageUseCase>(),sl<UpdateProductUseCase>()),
  );
  ///////////////////////////////////////
  sl.registerLazySingleton<SearchRemoteDataSources>(
        () => SearchRemoteDataSourcesImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<SearchProductRepository>(
        () => SearchProductRepositoryImpl(sl<SearchRemoteDataSources>()),
  );
  sl.registerLazySingleton(
        () => SearchProductUseCase(sl<SearchProductRepository>()),
  );
  sl.registerLazySingleton(
        () => AddFavoriteUseCase(sl<SearchProductRepository>()),
  );
  sl.registerLazySingleton(
        () => RemoveFavoriteUseCase(sl<SearchProductRepository>()),
  );
  sl.registerFactory<SearchCubit>(
        () => SearchCubit(sl<SearchProductUseCase>(),sl<AddFavoriteUseCase>(),sl<RemoveFavoriteUseCase>()),
  );
//////////////////////////////////////////////
  sl.registerLazySingleton<FavoriteRemoteDataSources>(
        () => FavoriteRemoteDataSourcesImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<FavoriteRepository>(
        () => FavoriteRepositoryImpl(sl<FavoriteRemoteDataSources>()),
  );
  sl.registerLazySingleton(
        () => GetFavoriteUseCase(sl<FavoriteRepository>()),
  );
  sl.registerLazySingleton(
        () => AddProductToFavoriteUseCase(sl<FavoriteRepository>()),
  );
  sl.registerLazySingleton(
        () => RemoveProductFromFavoriteUseCase(sl<FavoriteRepository>()),
  );
  sl.registerFactory<FavoriteCubit>(
        () => FavoriteCubit(sl<GetFavoriteUseCase>(),sl<RemoveProductFromFavoriteUseCase>(),sl<AddProductToFavoriteUseCase>()),
  );
  ///////////////////////////////////////////////
  sl.registerLazySingleton<MyProductRemoteDataSources>(
        () => MyProductRemoteDataSourcesImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<MyProductRepository>(
        () => MyProductRepositoryImpl(sl<MyProductRemoteDataSources>(),sl<AuthLocalDataSource>()),
  );
  sl.registerLazySingleton(
        () => GetMyProductUseCase(sl<MyProductRepository>()),
  );
  sl.registerLazySingleton(
        () => RemoveProductUseCase(sl<MyProductRepository>()),
  );
  sl.registerLazySingleton(
        () => UpdateIsSoldUesCase(sl<MyProductRepository>()),
  );
  sl.registerFactory<MyProductCubit>(
        () => MyProductCubit(sl<GetMyProductUseCase>(),sl<RemoveProductUseCase>(),sl<UpdateIsSoldUesCase>()),
  );
  ////////////////////////////////////////////////////
  sl.registerLazySingleton<ProfileRemoteDataSources>(
        () => ProfileRemoteDataSourcesImpl(sl<Dio>()),
  );
  sl.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(sl<ProfileRemoteDataSources>()),
  );
  sl.registerLazySingleton(
        () => ChangePasswordUseCase(sl<ProfileRepository>()),
  );
  sl.registerLazySingleton(
        () => UpdateProfileUseCase(sl<ProfileRepository>()),
  );
  sl.registerLazySingleton(
        () => UploadImageProfileUseCase(sl<ProfileRepository>()),
  );
  sl.registerFactory<ProfileCubit>(
        () => ProfileCubit(sl<AuthLocalDataSource>(),
            sl<ChangePasswordUseCase>(),sl<UpdateProfileUseCase>(),sl<UploadImageProfileUseCase>()),
  );
  sl.registerLazySingleton<LanguageCubit>(
        () => LanguageCubit(),
  );
  //////////////////
  sl.registerLazySingleton(() => Connectivity());

  sl.registerLazySingleton<NetworkCubit>(
        () => NetworkCubit(sl()),
  );
}