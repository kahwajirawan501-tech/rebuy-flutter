import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:roasters/core/di/service_locator.dart';
import 'package:roasters/features/auth/data/LocalDataSource/auth_local_data_source.dart';
import 'package:roasters/features/profile/presentation/cubit/cubit_languages.dart';

class DioClient {
  final Dio dio;
  final AuthLocalDataSource localDataSource;

  DioClient(this.localDataSource)
      : dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.101:3000',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  ) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await localDataSource.getToken();

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          } else {
            debugPrint("⚠️ TOKEN IS NULL OR EMPTY!");
          }
          // إضافة Accept-Language من LanguageCubit
          final languageCode = sl<LanguageCubit>().state.locale.languageCode;
          options.headers["Accept-Language"] = languageCode;

          debugPrint("Headers: ${options.headers}");
          if (kDebugMode) {
            debugPrint("➡️ REQUEST: ${options.method} ${options.path}");
            debugPrint("DATA: ${options.data}");
            debugPrint("DATA queryParameters: ${options.queryParameters}");
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            debugPrint("✅ RESPONSE: ${response.statusCode}");
            debugPrint("DATA: ${response.data}");
          }

          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            debugPrint("❌ ERROR: ${e.response?.statusCode}");
            debugPrint("❌ ERROR TYPE: ${e.type}");
            debugPrint("📑MESSAGE: ${e.response?.data}");
          }

          return handler.next(e);
        },
      ),
    );
  }

}