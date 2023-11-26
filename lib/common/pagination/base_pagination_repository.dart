import 'package:linku/common/pagination/pagination_params.dart';

abstract class BasePaginationRepository<T> {
  Future<List<T>> fetch({
    required PaginationParams params,
  });
}
