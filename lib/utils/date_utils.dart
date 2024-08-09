import 'package:intl/intl.dart';

String formatDate(DateTime time) {
  return DateFormat('yyyy/MM/dd').format(time);
}

String formatMonthDay(DateTime time) {
  return DateFormat('MM/dd').format(time);
}

String formatLatestMessageRelativeTime(DateTime time) {
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

String formatRelativeTime(DateTime time) {
  final now = DateTime.now();
  final difference = now.difference(time);
  if (difference.inDays >= 365) {
    final years = (difference.inDays / 365).floor();
    return '${years}year${years > 1 ? 's' : ''} years';
  } else if (difference.inDays >= 60) {
    return '${(difference.inDays / 30).floor()}months';
  } else if (difference.inDays >= 30) {
    return '1month';
  } else if (difference.inDays >= 14) {
    return '${(difference.inDays / 7).floor()}weeks';
  } else if (difference.inDays >= 7) {
    return '1week';
  } else if (difference.inDays >= 1) {
    return '${difference.inDays}days';
  } else if (difference.inHours >= 1) {
    return '${difference.inHours}h';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes}m';
  } else if (difference.inSeconds >= 1) {
    return '${difference.inSeconds}s';
  } else {
    return 'たった今';
  }
}
