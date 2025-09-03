// core/utils/calculate_reading_time.dart
int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;

  final readingTime = wordCount / 225;

  return readingTime.ceil();
}
