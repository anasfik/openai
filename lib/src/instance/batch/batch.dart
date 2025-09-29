import 'package:dart_openai/src/core/base/batch/batch.dart';
import 'package:dart_openai/src/core/models/batch/batch.dart';
import 'package:dart_openai/src/core/models/batch/batch_list.dart';
import 'package:dart_openai/src/core/models/batch/output_expires_after.dart';

class OpenAIBatch implements OpenAIBatchBase {
  @override
  Future<OpenAiBatchModel> create({
    required String completionWindow,
    required String endpoint,
    required String inputFileId,
    Map<String, dynamic>? metadata,
    OpenAIBatchoutputExpiresAfter? outputExpiresAfter,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAiBatchModel> get({
    required String batchId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAiBatchListModel> getAll({
    String? after,
    int? limit,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<OpenAiBatchModel> cancel({
    required String batchId,
  }) async {
    throw UnimplementedError();
  }
}
