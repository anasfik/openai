import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;

  final vectoreStoreFileBatch =
      await OpenAI.instance.vectorStores.vectorStoreFileBatch.create(
    vectorStoreId: "vs_6910ad9f45f481918e983e5a406cd77e",
    chunkingStrategy: OpenAIVectorStoreChunkingStrategy.static(
      chunkOverlapTokens: 200,
      maxChunkSizeTokens: 550,
    ),
    attributes: {
      "batch_name": "My First Batch",
    },
    fileIds: ["file-5Ajfuu3p7tAKhWLa25fNEB"],
  );

  print(vectoreStoreFileBatch.vectorStoreId);

  final gotBatchAsync =
      await OpenAI.instance.vectorStores.vectorStoreFileBatch.get(
    batchId: vectoreStoreFileBatch.id,
    vectorStoreId: vectoreStoreFileBatch.vectorStoreId!,
  );

  print(gotBatchAsync.status);

  await Future.delayed(const Duration(seconds: 2));

  // final cancelledBatch =
  //     await OpenAI.instance.vectorStores.vectorStoreFileBatch.cancel(
  //   batchId: vectoreStoreFileBatch.id,
  //   vectorStoreId: vectoreStoreFileBatch.vectorStoreId!,
  // );

  // print(cancelledBatch.status);

  final vectorStoreBatchFiles =
      await OpenAI.instance.vectorStores.vectorStoreFileBatch.list(
    vectorStoreId: "vs_6910ad9f45f481918e983e5a406cd77e",
    batchId: 'vsfb_ibj_6910c5ff37d081f4a1cc709111218a1e',
  );

  print(vectorStoreBatchFiles.data.length);
}
