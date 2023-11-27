import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/meet/model/meet_proposal_mode.dart';
import 'package:linku/meet/repository/meet_repository.dart';
import 'package:linku/user/model/user_model.dart';

final meetProposalProvider =
    StateNotifierProvider<MeetProposalStateNotifier, MeetProposalModel>(
  (ref) => MeetProposalStateNotifier(
    ref.watch(meetRepositoryProvider),
  ),
);

class MeetProposalStateNotifier extends StateNotifier<MeetProposalModel> {
  final MeetRepository repository;
  MeetProposalStateNotifier(
    this.repository,
  ) : super(
          MeetProposalModel(
            title: '',
            body: '',
            tagId: 0,
            maxParticipants: 2,
            meetTime: DateTime.now(),
            isOnline: false,
            location: '',
            minAge: 0,
            maxAge: 99,
          ),
        );

  void updateState({
    String? title,
    String? body,
    int? tagId,
    int? maxParticipants,
    DateTime? meetTime,
    bool? isOnline,
    Gender? gender,
    String? location,
    int? minAge,
    int? maxAge,
  }) {
    state = state.copyWith(
      title: title ?? state.title,
      body: body ?? state.body,
      tagId: tagId ?? state.tagId,
      maxParticipants: maxParticipants ?? state.maxParticipants,
      meetTime: meetTime ?? state.meetTime,
      gender: gender ?? state.gender,
      isOnline: isOnline ?? state.isOnline,
      location: location ?? state.location,
      minAge: minAge ?? state.minAge,
      maxAge: maxAge ?? state.maxAge,
    );
  }

  Future<void> create() async {
    try {
      await repository.create(model: state);
    } catch (e) {
      print(e);
    }
  }
}
