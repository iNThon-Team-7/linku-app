import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/tag/model/tag_model.dart';
import 'package:linku/tag/repository/tag_repository.dart';

final tagProvider =
    StateNotifierProvider.autoDispose<TagStateNotifier, List<TagModel>>((ref) {
  final repository = ref.watch(tagRepositoryProvider);
  return TagStateNotifier(
    repository: repository,
  );
});

class TagStateNotifier extends StateNotifier<List<TagModel>> {
  final TagRepository repository;
  TagStateNotifier({
    required this.repository,
  }) : super([]) {
    fetch();
  }

  Future<List<TagModel>> fetch() async {
    try {
      final data = await repository.fetch();
      state = data;
      return data;
    } catch (e) {
      return [];
    }
  }
}

// class TagStateNotifier
//     extends BasePaginationStateNotifier<TagRepository, TagModel> {
//   TagStateNotifier({
//     required TagRepository repository,
//   }) : super(repository);
// }
