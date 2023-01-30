import 'dart:io';

abstract class EditInterface {
  Future<void> edit({
    required File image,
    File? mask,
    required String prompt,
    int? n,
    String? size,
    String? responseFormat,
    String? user,
  });
}
