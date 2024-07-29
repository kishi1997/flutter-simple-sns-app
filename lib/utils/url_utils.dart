import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

String replaceLocalhostWithNetworkBaseUrl(String url) {
  if (Platform.isAndroid || Platform.isIOS) {
    if (url.startsWith('http://localhost')) {
      return url.replaceFirst(
          'http://localhost', dotenv.get('LOCAL_NETWORK_BASE_URL'));
    }
  }
  return url;
}
