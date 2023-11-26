import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:linku/common/const/data.dart';
import 'package:linku/common/firebase/fcm_handler.dart';
import 'package:linku/common/provider/storage.dart';
import 'package:linku/user/model/login_model.dart';
import 'package:linku/user/model/user_model.dart';
import 'package:linku/user/repository/auth_repository.dart';
import 'package:linku/user/repository/user_repository.dart';

final userProvider =
    StateNotifierProvider<UserStateNotifier, UserModelBase?>((ref) {
  final repository = ref.read(authRepositoryProvider);
  final userRepository = ref.read(userRepositoryProvider);
  final storage = ref.read(storageProvider);
  final fcm = ref.watch(fcmTokenProvider.notifier);

  return UserStateNotifier(
    repository: repository,
    userRepository: userRepository,
    storage: storage,
    fcm: fcm,
  );
});

class UserStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository repository;
  final UserRepository userRepository;
  final FlutterSecureStorage storage;
  final FcmTokenStateNotifier fcm;
  UserStateNotifier({
    required this.repository,
    required this.userRepository,
    required this.storage,
    required this.fcm,
  }) : super(null) {
    getMe();
  }

  Future<void> getMe() async {
    try {
      final user = await userRepository.getMe();
      state = user;
      fcm.uploadToken();
    } catch (e) {
      //TODO: handle error
      state = UserModelError(message: 'error');
    }
  }


  Future<void> loginInstatnt() async {
    try {
      print("loginInstatnt");
      // await storage.write(key: accessTokenKey, value: accessTokenExam);
      // await storage.write(key: refreshTokenKey, value: "refreshToken");
      await getMe();
    } catch (e) {
      //TODO: handle error
    }
  }

  Future<void> login({
    required LoginModel loginModel,
  }) async {
    try {
      final response = await repository.login(loginModel);

      final accessToken = response.accessToken;
      final refreshToken = response.refreshToken;

      await storage.write(key: accessTokenKey, value: accessToken);
      await storage.write(key: refreshTokenKey, value: refreshToken);

      await getMe();
    } catch (e) {
      //TODO: handle error
    }
  }

  Future<void> logout() async {
    try {
      await repository.logout();

      await storage.delete(key: accessTokenKey);
      await storage.delete(key: refreshTokenKey);

      state = null;
    } catch (e) {
      //TODO: handle error
    }
  }

  Future<void> register({
    required LoginModel loginModel,
  }) async {
    try {
      await repository.register(
        loginModel,
      );
      await login(loginModel: loginModel);
    } catch (e) {
      //TODO: handle error
      print(e);
    }
  }

  Future<void> fcmTokenUpload() async {
    try {
      final token = await storage.read(key: fcmTokenKey);
      await repository.updateFcmToken(
        {
          'fcmToken': token,
        },
      );
    } catch (e) {
      //TODO: handle error
    }
  }

  void setUser(UserModel user) {
    state = user;
  }
}
