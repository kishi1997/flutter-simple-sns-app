class Pagination {
  final int? cursor;
  final bool? isNext;
  final int? size;
  final String? order;

  Pagination({
    this.cursor,
    this.isNext,
    this.size,
    this.order,
  });
}

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
