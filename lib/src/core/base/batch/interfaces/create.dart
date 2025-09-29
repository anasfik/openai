import 'package:dart_openai/src/core/models/batch/batch.dart';
import 'package:dart_openai/src/core/models/batch/output_expires_after.dart';

abstract class CreateInterface {
  Future<OpenAiBatchModel> create({
    required String completionWindow,
    required String endpoint,
    required String inputFileId,
    Map<String, dynamic>? metadata,
    OpenAIBatchoutputExpiresAfter? outputExpiresAfter,
  });
}
