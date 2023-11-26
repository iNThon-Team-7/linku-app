import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/common/const/data.dart';
import 'package:linku/common/pagination/base_pagination_repository.dart';
import 'package:linku/common/pagination/pagination_params.dart';
import 'package:linku/common/provider/dio.dart';
import 'package:linku/meet/model/meet_detail_model.dart';
import 'package:linku/meet/model/meet_model.dart';
import 'package:linku/meet/model/meet_proposal_mode.dart';
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

final meetRepositoryProvider = Provider<MeetRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return MeetRepository(dio, baseUrl: '$ip/meet');
});

@RestApi()
abstract class MeetRepository {
  factory MeetRepository(Dio dio, {String baseUrl}) = _MeetRepository;

  @POST('')
  @Headers({
    'accessToken': 'true',
  })
  Future<void> create({
    @Body() required MeetProposalModel model,
  });

  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<MeetDetailModel> meetDetail({
    @Path('id') required int id,
  });

  @POST('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<void> join({
    @Path('id') required int id,
  });
}
