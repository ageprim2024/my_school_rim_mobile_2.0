import '../constants/expression.dart';

double getPeriodeValue(String periodeName) {
  switch (periodeName) {
    case periodSecondName:
      return periodSecond;
    case periodHourName:
      return periodHour;
    case periodDayName:
      return periodDay;
    case periodWeekName:
      return periodWeek;
    case periodMonthName:
      return periodMonth;
    case periodYearName:
      return periodYear;
    default:
      return 0;
  }
}
