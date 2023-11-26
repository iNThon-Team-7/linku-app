import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/common/const/data.dart';
import 'package:linku/common/pagination/base_pagination_repository.dart';
import 'package:linku/common/pagination/pagination_params.dart';
import 'package:linku/common/provider/dio.dart';
import 'package:linku/history/model/history_model.dart';
import 'package:retrofit/retrofit.dart';

part 'history_repository.g.dart';

final historyPaginationRepositoryProvider =
Provider<HistoryPaginationRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return HistoryPaginationRepository(dio, baseUrl: '$ip/history');
});

@RestApi()
abstract class HistoryPaginationRepository
    extends BasePaginationRepository<HistoryModel> {
  factory HistoryPaginationRepository(Dio dio, {String baseUrl}) =
  _HistoryPaginationRepository;

  @override
  @GET('')
  @Headers({'accessToken': 'true'})
  Future<List<HistoryModel>> fetch({
    @Queries() required PaginationParams params,
  });
}
