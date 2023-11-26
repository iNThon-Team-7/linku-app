import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:linku/common/pagination/base_pagination_repository.dart';
import 'package:linku/common/pagination/pagination_params.dart';

class BasePaginationStateNotifier<T extends BasePaginationRepository<U>, U>
    extends StateNotifier<List<U>> {
  final T repository;
  BasePaginationStateNotifier(
    this.repository,
  ) : super([]);

  Future<List<U>> fetch({
    required PagingController controller,
    int page = 0,
    int size = 20,
  }) async {
    try {
      final data = await repository.fetch(
        params: PaginationParams(
          page: page,
          size: size,
        ),
      );
      state = data;
      if (data.isEmpty) {
        controller.appendLastPage([]);
        return [];
      }
      controller.appendPage(data, page + 1);
      return data;
    } catch (e) {
      return [];
    }
  }
}
