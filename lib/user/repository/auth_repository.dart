import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/common/const/data.dart';
import 'package:linku/common/provider/dio.dart';
import 'package:linku/user/model/login_model.dart';
import 'package:linku/user/model/login_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_repository.g.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio, baseUrl: '$ip/auth');
});

@RestApi()
abstract class AuthRepository {
  factory AuthRepository(Dio dio, {String baseUrl}) = _AuthRepository;

  @POST('/login')
  Future<LoginResponseModel> login(
    @Body() LoginModel loginModel,
  );

  @POST('/register')
  Future<void> register(
    @Body() LoginModel loginModel,
  );

  @POST('/fcm')
  @Headers({
    'accessToken': 'true',
  })
  Future<void> updateFcmToken(
    @Body() Map<String, dynamic> body,
  );

  @POST('/logout')
  Future<void> logout();
}
