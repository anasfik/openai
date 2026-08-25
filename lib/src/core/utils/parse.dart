/// Tolerant field-extraction helpers for model parsing.
///
/// API-compatible providers and future schema drift must degrade to
/// defaults instead of crashing a running app.
library;

int intOr(Object? value, [int fallback = 0]) => value is int
    ? value
    : (value is num ? value.toInt() : int.tryParse('$value') ?? fallback);

double doubleOr(Object? value, [double fallback = 0]) => value is double
    ? value
    : (value is num ? value.toDouble() : double.tryParse('$value') ?? fallback);

String stringOr(Object? value, [String fallback = '']) =>
    value?.toString() ?? fallback;

bool boolOr(Object? value, [bool fallback = false]) =>
    value is bool ? value : fallback;

Map<String, dynamic> mapOr(Object? value) =>
    value is Map<String, dynamic> ? value : const {};

List<dynamic> listOr(Object? value) => value is List ? value : const [];
