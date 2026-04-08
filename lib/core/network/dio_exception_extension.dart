import 'package:dio/dio.dart';

extension DioExceptionExtension on DioException {
  String get friendlyMessage {
    if (type == DioExceptionType.connectionTimeout) return "Connection timeout";
    if (type == DioExceptionType.receiveTimeout) return "Receive timeout";
    if (type == DioExceptionType.badResponse) {
      final data = response?.data;
      if (data == null) return "Server error";
      if (data is Map<String, dynamic>) return data["message"] ?? data["error"] ?? "Server error";
      if (data is String) return data;
      return "Server error";
    }
    if (type == DioExceptionType.cancel) return "Request cancelled";
    return "Unexpected error occurred";
  }
}