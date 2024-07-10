import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url) async {
  try {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Cannot launch URL';
    }
  } catch (e) {
    throw 'Failed to launch $url: $e';
  }
}
