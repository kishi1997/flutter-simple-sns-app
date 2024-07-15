import 'package:intl/intl.dart';

String formatDate(DateTime time) {
  return DateFormat('yyyy-MM-dd').format(time);
}
