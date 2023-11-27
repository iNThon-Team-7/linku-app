import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/tag/model/tag_model.dart';
import 'package:linku/tag/repository/tag_repository.dart';
import 'package:linku/user/model/user_model.dart';
import 'package:linku/user/provider/user_provider.dart';

final tagSelectionProvider =
    StateNotifierProvider<StateNotifierProviderTagSelection, List<TagModel>>(
        (ref) {
  final repository = ref.read(tagRepositoryProvider);
  final user = ref.watch(userProvider);
  return StateNotifierProviderTagSelection(
    repository: repository,
    initialTags: user == null || user is! UserModel ? [] : user.tags ?? [],
  );
});

final singleTagSelectionProvider =
    StateNotifierProvider<StateNotifierProviderTagSelection, List<TagModel>>(
        (ref) {
  final repository = ref.read(tagRepositoryProvider);
  return StateNotifierProviderTagSelection(
    repository: repository,
    initialTags: [],
  );
});

class StateNotifierProviderTagSelection extends StateNotifier<List<TagModel>> {
  final TagRepository repository;
  final List<TagModel> initialTags = [];
  StateNotifierProviderTagSelection({
    required this.repository,
    required List<TagModel> initialTags,
  }) : super(initialTags);

  void single(TagModel tag) {
    state = [tag];
  }

  Future<void> add(TagModel tag) async {
    state = [...state, tag];
    await repository.subscribe(tag.id);
  }

  Future<void> remove(TagModel tag) async {
    state = state.where((element) => element.id != tag.id).toList();
    await repository.unsubscribe(tag.id);
  }

  void clear() {
    state = [];
  }

  bool contains(TagModel tag) {
    return state.any((element) => element.id == tag.id);
  }

  bool isEmpty() {
    return state.isEmpty;
  }

  bool isNotEmpty() {
    return state.isNotEmpty;
  }

  List<TagModel> get() {
    return state;
  }
}
