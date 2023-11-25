import 'package:linku/common/exception/custom_exceptions.dart';

class CustomExceptionHandler {
  static hanldeException(dynamic error) {
    if (error is CustomException) {
      // TODO: Handle custom exception
    } else if (error is Exception) {
      print(error);
    } else {
      print(error);
    }
  }
}
