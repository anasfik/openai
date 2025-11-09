import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;

  final createdVectorStoreFile =
      await OpenAI.instance.vectorStores.vectorStoresFiles.create(
    vectorStoreId: "vs_6910ad9f45f481918e983e5a406cd77e",
    fileId: "file-2wlzJ8i9nTsz0kzrVTXBU2HC",
    attributes: {
      "chapter": "Chapter 1",
    },
    chunckingStrategy: OpenAIVectorStoreChunkingStrategy.static(
      chunkOverlapTokens: 300,
      maxChunkSizeTokens: 750,
    ),
  );

  print(createdVectorStoreFile.id);

  final vectorStoreFiles =
      await OpenAI.instance.vectorStores.vectorStoresFiles.list(
    vectoreStoreId: "vs_6910ad9f45f481918e983e5a406cd77e",
    limit: 60,
  );

  print(vectorStoreFiles.data.length);

  if (vectorStoreFiles.data.isNotEmpty) {
    final vectorStoreFile =
        await OpenAI.instance.vectorStores.vectorStoresFiles.get(
      fileId: vectorStoreFiles.data.first.id,
      vectorStoreId: "vs_6910ad9f45f481918e983e5a406cd77e",
    );

    print(vectorStoreFile.id);

    final vectorStoreFileContent =
        await OpenAI.instance.vectorStores.vectorStoresFiles.getContent(
      fileId: vectorStoreFiles.data.first.id,
      vectorStoreId: "vs_6910ad9f45f481918e983e5a406cd77e",
    );

    print(vectorStoreFileContent);

    final updatedVectorStoreFile =
        await OpenAI.instance.vectorStores.vectorStoresFiles.update(
      fileId: vectorStoreFiles.data.first.id,
      vectorStoreId: "vs_6910ad9f45f481918e983e5a406cd77e",
      attributes: {
        "chapter": "Updated Chapter 1",
      },
    );

    print(updatedVectorStoreFile.id);

    await OpenAI.instance.vectorStores.vectorStoresFiles.delete(
      fileId: vectorStoreFiles.data.first.id,
      vectorStoreId: "vs_6910ad9f45f481918e983e5a406cd77e",
    );

    print('Vector store file deleted');
  }
}
