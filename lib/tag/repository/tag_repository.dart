import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/common/const/data.dart';
import 'package:linku/common/provider/dio.dart';
import 'package:linku/tag/model/tag_model.dart';
import 'package:retrofit/http.dart';

part 'tag_repository.g.dart';

final tagRepositoryProvider = Provider<TagRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return TagRepository(dio, baseUrl: '$ip/tag');
});

// @RestApi()
// abstract class TagRepository implements BasePaginationRepository<TagModel> {
//   factory TagRepository(Dio dio, {String baseUrl}) = _TagRepository;

//   @override
//   @GET('')
//   Future<List<TagModel>> fetch({
//     @Queries() required PaginationParams params,
//   });
// }

@RestApi()
abstract class TagRepository {
  factory TagRepository(Dio dio, {String baseUrl}) = _TagRepository;

  @GET('')
  Future<List<TagModel>> fetch();

  @POST('/{id}/subscription')
  @Headers({'accessToken': 'true'})
  Future<void> subscribe(@Path('id') int id);

  @DELETE('/{id}/subscription')
  @Headers({'accessToken': 'true'})
  Future<void> unsubscribe(@Path('id') int id);
}
