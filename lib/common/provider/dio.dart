import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:linku/common/const/data.dart';
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
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    print('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await storage.read(key: accessTokenKey);

      options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri} : ${response.statusCode}',
      );
    } catch (e) {
      print(e);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
      '[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri} ${err.response?.statusCode} ${err.response}',
    );

    final refreshToken = await storage.read(key: refreshTokenKey);

    if (refreshToken == null) {
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path ==
        '/auth/refresh'; // check is error occurred from token refreshing api => if true, there is nothing we can do to fix this error

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final resp = await dio.post(
          '$ip/auth/refresh',
          options: Options(),
          data: {
            'refreshToken': refreshToken,
          },
        );
        final newAccessToken = resp.data['accessToken'];
        final newRefreshToken = resp.data['refreshToken'];

        final options = err.requestOptions;

        options.headers.addAll({
          'ACCESS_AUTHORIZATION': 'Bearer $newAccessToken',
        });

        await storage.write(key: accessTokenKey, value: newAccessToken);
        await storage.write(key: refreshTokenKey, value: newRefreshToken);

        Response response = await dio.fetch(err.requestOptions);

        print(
          '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri} ${response.statusCode}',
        );

        return handler.resolve(response);
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          await storage.delete(key: accessTokenKey);
          await storage.delete(key: refreshTokenKey);

          return handler.reject(e);
        }
        return handler.reject(e);
      }
    }

    return handler.reject(err);
  }
}
