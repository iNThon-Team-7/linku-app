abstract class Utils {
  static fromUTCtoKRYYYYMMDDHHMMSS(DateTime utc) {
    final date = utc.toLocal();
    return '${date.year}년 ${date.month.toString().padLeft(2, '0')}월 ${date.day.toString().padLeft(2, '0')}일 ${date.hour.toString().padLeft(2, '0')}시 ${date.minute.toString().padLeft(2, '0')}분';
  }
}
