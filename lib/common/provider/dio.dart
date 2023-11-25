import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:linku/common/provider/storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  final stroage = ref.watch(storageProvider);

  dio.interceptors.add(CustomExceptionHandler(stroage));

  return dio;
});

class CustomExceptionHandler extends Interceptor {
  final FlutterSecureStorage storage;

  CustomExceptionHandler(this.storage);
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}
