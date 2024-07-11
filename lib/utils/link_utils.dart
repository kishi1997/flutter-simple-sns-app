import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url) async {
  try {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Cannot launch URL');
    }
  } catch (e) {
    throw Exception('Failed to launch $url: $e');
  }
}
