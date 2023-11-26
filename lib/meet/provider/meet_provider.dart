import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/common/pagination/base_pagination_provider.dart';
import 'package:linku/meet/model/meet_model.dart';
import 'package:linku/meet/repository/meet_repository.dart';

final meetPaginationProvider =
    StateNotifierProvider<MeetStateNotifier, List<MeetModel>>((ref) {
  final repository = ref.watch(meetPaginationRepositoryProvider);
  return MeetStateNotifier(repository: repository);
});

class MeetStateNotifier
    extends BasePaginationStateNotifier<MeetPaginationRepository, MeetModel> {
  MeetStateNotifier({
    required MeetPaginationRepository repository,
  }) : super(repository);
}
