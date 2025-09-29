import 'package:dart_openai/src/core/models/batch/batch.dart';

abstract class CancelInterface {
  Future<OpenAiBatchModel> cancel({
    required String batchId,
  });
}
