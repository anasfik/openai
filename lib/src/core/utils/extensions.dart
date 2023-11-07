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
    final day = this.day.toString().padLeft(2, "0");
    final month = this.month.toString().padLeft(2, "0");
    final year = this.year.toString().padLeft(4, "0");

    return "${year}-${month}-${day}";
  }
}
