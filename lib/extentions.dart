extension DateTimeExtension on DateTime {
  DateTime getFirstDateOfCalendarMonth({int startDayOfWeek = DateTime.sunday}) {
    assert(startDayOfWeek != DateTime.monday || startDayOfWeek != DateTime.sunday);

    final firstDateOfMonth = DateTime(year, month, 1);
    if (startDayOfWeek == DateTime.monday) {
      return DateTime(year, month, 1).subtract(
        Duration(days: firstDateOfMonth.weekday - 1),
      );
    } else {
      return DateTime(year, month, 1).subtract(
        Duration(
          days:
              firstDateOfMonth.weekday == DateTime.sunday ? 0 : firstDateOfMonth.weekday,
        ),
      );
    }
  }
}
