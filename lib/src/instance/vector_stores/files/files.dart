import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/vector_stores/chunking_strategy.dart';
import 'package:dart_openai/src/core/models/vector_stores/vector_store_file_list.dart';
import 'package:dart_openai/src/core/models/vector_stores/vectore_store_file.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:dart_openai/src/core/base/vector_stores/files/files.dart';

class OpenAIVectorStoreFiles extends OpenAIVectorStoreFilesBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.vectorStores;

  @override
  Future<OpenAIVectorStoreFileModel> create({
    required String vectorStoreId,
    required String fileId,
    Map<String, dynamic>? attributes,
    OpenAIVectorStoreChunkingStrategy? chunckingStrategy,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIVectorStoreFileModel>(
      to: BaseApiUrlBuilder.build(
        endpoint,
        "$vectorStoreId/files",
      ),
      body: {
        "file_id": fileId,
        if (attributes != null) "attributes": attributes,
        if (chunckingStrategy != null)
          "chunking_strategy": chunckingStrategy.toMap(),
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIVectorStoreFileModel.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAIVectorStoreFileModel> get({
    required String fileId,
    required String vectorStoreId,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIVectorStoreFileModel>(
      from: BaseApiUrlBuilder.build(
        endpoint,
        "$vectorStoreId/files/$fileId",
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIVectorStoreFileModel.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAIVectorStoreFileListModel> list({
    required String vectoreStoreId,
    String? after,
    String? before,
    int? limit,
    String? order,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIVectorStoreFileListModel>(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: endpoint + "/$vectoreStoreId/files",
        query: {
          if (after != null) "after": after,
          if (before != null) "before": before,
          if (limit != null) "limit": limit.toString(),
          if (order != null) "order": order,
        },
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIVectorStoreFileListModel.fromMap(response);
      },
    );
  }

  @override
  Future getContent({
    required String fileId,
    required String vectorStoreId,
  }) async {
    return await OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.build(
        endpoint,
        "$vectorStoreId/files/$fileId/content",
      ),
      returnRawResponse: true,
    );
  }

  @override
  Future<OpenAIVectorStoreFileModel> update({
    required String fileId,
    required String vectorStoreId,
    required Map<String, dynamic> attributes,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIVectorStoreFileModel>(
      to: BaseApiUrlBuilder.build(
        endpoint,
        "$vectorStoreId/files/$fileId",
      ),
      body: {
        "attributes": attributes,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIVectorStoreFileModel.fromMap(response);
      },
    );
  }

  @override
  Future<void> delete({
    required String fileId,
    required String vectorStoreId,
  }) async {
    return await OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.build(
        endpoint,
        "$vectorStoreId/files/$fileId",
      ),
      onSuccess: (_) => {},
    );
  }
}
