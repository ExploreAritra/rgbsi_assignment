class DateUtil {
  static int daysSince({required DateTime? dateTime}) {
    if(dateTime != null) {
      return DateTime.now().difference(dateTime).inDays;
    } else {
      return 0;
    }
  }
}