import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/common/const/data.dart';
import 'package:linku/common/provider/dio.dart';
import 'package:linku/user/model/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'user_repository.g.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return UserRepository(dio, baseUrl: '$ip/user');
});

@RestApi()
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  @GET('/auth')
  @Headers({
    'accessToken': 'true',
  })
  Future<UserModel> getMe();

  @PATCH('/profile')
  @Headers({
    'accessToken': 'true',
  })
  Future<void> updateProfile(
    @Body() Map<String, dynamic> body,
  );

  @PATCH('/image')
  @Headers({'accessToken': 'true', 'Content-Type': 'multipart/form-data'})
  Future<void> updateProfileImage(
    @Body() FormData image,
  );
}
