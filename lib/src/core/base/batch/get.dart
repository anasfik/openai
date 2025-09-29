import 'package:dart_openai/src/core/models/batch/batch.dart';
import 'package:dart_openai/src/core/models/batch/batch_list.dart';

abstract class GetInterface {
  Future<OpenAiBatchModel> get({
    required String batchId,
  });

  Future<OpenAiBatchListModel> getAll({
    required String? after,
    required int? limit,
  });
}
