import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';

Future<void> loadEnvironmentVariables() async {
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    logError(e);
  }
}
