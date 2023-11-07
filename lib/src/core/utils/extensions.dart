import 'dart:convert';

extension StringExtension on String {
  bool get canBeParsedToJson {
    try {
      final _ = jsonDecode(this);

      return true;
    } catch (e) {
      return false;
    }
  }
}

extension DateTimeExt on DateTime {
  String toAzureAPIVersionString() {
    return "${year}-${month}-${day}";
  }
}
