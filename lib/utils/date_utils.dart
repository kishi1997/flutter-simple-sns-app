import 'package:intl/intl.dart';

String formatDate(DateTime time) {
  return DateFormat('yyyy/MM/dd').format(time);
}

String getlatestMessageTime(DateTime time) {
  final now = DateTime.now();
  final difference = now.difference(time);
  if (difference.inDays >= 1) {
    return formatDate(time);
  } else if (difference.inHours >= 1) {
    return '${difference.inHours}時間前';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes}分前';
  } else if (difference.inSeconds >= 1) {
    return '${difference.inSeconds}秒前';
  } else {
    return 'たった今';
  }
}
