import 'package:logger/logger.dart';

var logger = Logger();

void logError(dynamic error) {
  logger.e('$error');
}
