import 'package:linku/common/model/custom_button_model.dart';
import 'package:linku/common/model/custom_dialog_model.dart';

class CustomException implements Exception {
  final String message;
  final CustomDialogModel dialogModel;

  CustomException({
    required this.message,
    required this.dialogModel,
  });

  @override
  String toString() {
    return 'error occurred : $message';
  }
}

class MeetMaxParticipantException extends CustomException {
  MeetMaxParticipantException()
      : super(
          message: '모임 최대 인원을 초과했습니다.',
          dialogModel: CustomDialogModel(
            title: '모임 최대 인원 초과',
            description: '모임 최대 인원을 초과했습니다.',
            customButtonModel: CustomButtonModel(
              title: '확인',
            ),
          ),
        );
}

class MeetJoinSuccessException extends CustomException {
  MeetJoinSuccessException()
      : super(
          message: '모임 참여에 성공했습니다.',
          dialogModel: CustomDialogModel(
            title: '모임 참여 성공',
            description: '모임 참여에 성공했습니다.',
            customButtonModel: CustomButtonModel(
              title: '확인',
            ),
          ),
        );
}
