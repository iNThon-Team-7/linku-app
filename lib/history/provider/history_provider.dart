import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/common/pagination/base_pagination_provider.dart';
import 'package:linku/history/model/history_model.dart';
import 'package:linku/history/repository/history_repository.dart';


final historyPaginationProvider =
StateNotifierProvider<HistoryStateNotifier, List<HistoryModel>>((ref) {
  final repository = ref.watch(historyPaginationRepositoryProvider);
  return HistoryStateNotifier(repository: repository);
});

class HistoryStateNotifier
    extends BasePaginationStateNotifier<HistoryPaginationRepository, HistoryModel> {
  HistoryStateNotifier({
    required HistoryPaginationRepository repository,
  }) : super(repository);
}
