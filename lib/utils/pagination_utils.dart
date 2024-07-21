import 'package:simple_sns_app/domain/message/message_service.dart';

Map<String, dynamic> buildPagiationParameters(Pagination? pagination) {
  final queryParameters = <String, dynamic>{};
  if (pagination != null) {
    queryParameters.addAll({
      if (pagination.cursor != null) 'pagination[cursor]': pagination.cursor,
      if (pagination.isNext != null) 'pagination[isNext]': pagination.isNext,
      if (pagination.size != null) 'pagination[size]': pagination.size,
      if (pagination.order != null) 'pagination[order]': pagination.order,
    });
  }
  return queryParameters;
}
