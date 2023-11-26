import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/common/const/data.dart';
import 'package:linku/common/pagination/base_pagination_repository.dart';
import 'package:linku/common/pagination/pagination_params.dart';
import 'package:linku/common/provider/dio.dart';
import 'package:linku/meet/model/meet_model.dart';
import 'package:retrofit/retrofit.dart';

part 'meet_repository.g.dart';

final meetPaginationRepositoryProvider =
    Provider<MeetPaginationRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return MeetPaginationRepository(dio, baseUrl: '$ip/meet');
});

@RestApi()
abstract class MeetPaginationRepository
    extends BasePaginationRepository<MeetModel> {
  factory MeetPaginationRepository(Dio dio, {String baseUrl}) =
      _MeetPaginationRepository;

  @override
  @GET('')
  @Headers({'accessToken': 'true'})
  Future<List<MeetModel>> fetch({
    @Queries() required PaginationParams params,
  });
}
