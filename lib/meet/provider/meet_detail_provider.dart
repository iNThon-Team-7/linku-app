import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/common/exception/custom_exceptions.dart';
import 'package:linku/meet/model/meet_model.dart';
import 'package:linku/meet/repository/meet_repository.dart';

final meetDetailProvider =
    StateNotifierProvider.family<MeetDetailStateNotifier, MeetModelBase, int>(
        (ref, id) {
  final repository = ref.watch(meetRepositoryProvider);
  return MeetDetailStateNotifier(
    meetId: id,
    repository: repository,
  );
});

class MeetDetailStateNotifier extends StateNotifier<MeetModelBase> {
  final int meetId;
  final MeetRepository repository;
  MeetDetailStateNotifier({
    required this.meetId,
    required this.repository,
  }) : super(MeetModelLoading()) {
    fetch();
  }

  Future<void> fetch() async {
    try {
      final data = await repository.meetDetail(id: meetId);
      state = data;
    } catch (e) {
      state = MeetModelError(
        message: '모임 정보를 불러오는데 실패했습니다.',
      );
    }
  }

  Future<void> join() async {
    try {
      await repository.join(id: meetId);
      throw MeetJoinSuccessException();
    } on DioException catch (e) {
      if (e.response?.data['message'] == '모임의 최대 인원을 초과했습니다.') {
        state = MeetModelError(
          message: '모임의 최대 인원을 초과했습니다.',
        );
        throw MeetMaxParticipantException();
      }
      state = MeetModelError(
        message: '모임 참여에 실패했습니다.',
      );
    }
  }
}
