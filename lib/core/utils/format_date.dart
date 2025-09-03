// core/utils/format_date.dart
import 'package:intl/intl.dart';

String formatDateBydMMMYYYY(DateTime dateTime) {
  return DateFormat("d MMM, yyyy").format(dateTime);
}
