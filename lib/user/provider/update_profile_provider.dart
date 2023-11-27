import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/user/model/update_profile_model.dart';
import 'package:linku/user/model/user_model.dart';
import 'package:linku/user/repository/user_repository.dart';

final updateProfileProvider =
    StateNotifierProvider<UpdateProfileProvider, UpdateProfileModel>((ref) {
  final repository = ref.watch(userRepositoryProvider);

  return UpdateProfileProvider(
    repository,
  );
});

class UpdateProfileProvider extends StateNotifier<UpdateProfileModel> {
  final UserRepository repository;
  UpdateProfileProvider(
    this.repository,
  ) : super(UpdateProfileModel());

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateIntro(String intro) {
    state = state.copyWith(intro: intro);
  }

  void updateAge(int age) {
    state = state.copyWith(age: age);
  }

  void updateGender(Gender gender) {
    state = state.copyWith(gender: gender);
  }

  updateImgFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        withData: true,
        type: FileType.image,
      );
      if (result != null) {
        state = state.copyWith(imgFile: result);
      }
    } catch (e) {
      print(e);
    }
  }

  bool isProfileUpdated() {
    return state.age != null ||
        state.gender != null ||
        state.name != null ||
        state.intro != null;
  }

  bool isImageUpdated() {
    return state.imgFile != null;
  }

  Future<bool> upload({
    required Function callback,
  }) async {
    await uplaodProfile();
    await uploadImage();
    await callback();
    dispose();
    return true;
  }

  Future<void> uplaodProfile() async {
    try {
      if (isProfileUpdated()) {
        await repository.updateProfile(state.updateOthers());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadImage() async {
    try {
      if (isImageUpdated()) {
        await repository.updateProfileImage(state.updateImage());
      }
    } catch (e) {
      print(e);
    }
  }
}
