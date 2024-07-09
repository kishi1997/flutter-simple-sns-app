import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url) async {
  try {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Cannot launch URL';
    }
  } catch (e) {
    throw 'Failed to launch $url: $e';
  }
}
