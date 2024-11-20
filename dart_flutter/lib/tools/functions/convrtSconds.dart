

String convertSeconds(String second) {
  double s = double.parse(second);
  int seconds = s.toInt();
  Duration duration = Duration(seconds: seconds);

  int days = duration.inDays;
  int hours = duration.inHours.remainder(24);
  int minutes = duration.inMinutes.remainder(60);
  int remainingSeconds = duration.inSeconds.remainder(60);

  String formattedDuration = '';

  if (days > 0) {
    formattedDuration += '$days يوم ';
  }
  if (hours > 0) {
    formattedDuration += '$hours ساعة ';
  }
  if (minutes > 0) {
    formattedDuration += '$minutes دقيقة ';
  }
  if (remainingSeconds > 0) {
    formattedDuration += '$remainingSeconds ثانية';
  }

  return formattedDuration.trim();
}