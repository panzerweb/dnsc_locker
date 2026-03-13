import 'package:intl/intl.dart';

String formatDate(String dateToFormat) {
  final DateTime parsedDate = DateTime.parse(dateToFormat);
  return DateFormat('MMMM d, yyyy').format(parsedDate);
}
