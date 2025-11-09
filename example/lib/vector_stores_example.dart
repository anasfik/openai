import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;

  final vectorStore = await OpenAI.instance.vectorStores.vectorStores.create(
    chunkingStrategy: OpenAIVectorStoreChunkingStrategy.static(
      chunkOverlapTokens: 300,
      maxChunkSizeTokens: 750,
    ),
    expiresAfter: OpenAIVectorStoreExpiresAfter(
      anchor: "last_active_at",
      days: 1,
    ),
    name: "example_vector_store",
  );

  print(vectorStore.id);

  await Future.delayed(Duration(milliseconds: 100));

  final allVEctorStores =
      await OpenAI.instance.vectorStores.vectorStores.list(limit: 30);

  print(allVEctorStores.data.length);

  if (allVEctorStores.data.isNotEmpty) {
    final firstVectorStoreAsync =
        await OpenAI.instance.vectorStores.vectorStores.get(
      vectorStoreId: allVEctorStores.data.first.id,
    );

    print(firstVectorStoreAsync.id);

    final updatedVectorStore =
        await OpenAI.instance.vectorStores.vectorStores.modify(
      vectorStoreId: firstVectorStoreAsync.id,
      name: "updated_vector_store_name${DateTime.now().toIso8601String()}",
    );

    print(updatedVectorStore.name);

    await Future.delayed(Duration(milliseconds: 100));

    final searchVEctorStoreResult =
        await OpenAI.instance.vectorStores.vectorStores.search(
      vectorStoreId: updatedVectorStore.id,
      query: "example",
      maxNumResults: 10,
      filters: OpenAIVectorStoresSearchFilter.comparison(
        type: "eq",
        key: "metadata.example_key",
        value: "example_value",
      ),
      rankingOptions: OpenAIVectorStoresRankingOptions(
        ranker: "none",
        scoreThreshold: 0,
      ),
    );

    print(searchVEctorStoreResult);
    return;

    await OpenAI.instance.vectorStores.vectorStores.delete(
      vectorStoreId: updatedVectorStore.id,
    );

    print("deleted");
  }
}
