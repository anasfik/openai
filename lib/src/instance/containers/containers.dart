import 'package:dart_openai/src/core/base/container/containers/containers.dart';
import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/containers/container.dart';
import 'package:dart_openai/src/core/models/containers/containers_list.dart';
import 'package:dart_openai/src/core/models/containers/expires_after.dart';
import 'package:dart_openai/src/core/networking/client.dart';

class OpenAIContainers extends OpenAIContainersBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.containers;

  @override
  Future<OpenAIContainer> create({
    required String name,
    OpenAIContainerExpiresAfter? expiresAfter,
    List<String>? fileIds,
  }) async {
    return await OpenAINetworkingClient.post<OpenAIContainer>(
      to: BaseApiUrlBuilder.build(endpoint),
      body: {
        'name': name,
        if (expiresAfter != null) 'expires_after': expiresAfter.toMap(),
        if (fileIds != null) 'file_ids': fileIds,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIContainer.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAIContainerList> list({
    String? after,
    int? limit,
    String? order,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIContainerList>(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: endpoint,
        query: {
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
          if (order != null) 'order': order,
        },
      ),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIContainerList.fromMap(response);
      },
    );
  }

  @override
  Future<OpenAIContainer> get({
    required String containerId,
  }) async {
    return await OpenAINetworkingClient.get<OpenAIContainer>(
      from: BaseApiUrlBuilder.build(endpoint, containerId),
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIContainer.fromMap(response);
      },
    );
  }

  @override
  Future<void> delete({
    required String containerId,
  }) async {
    return await OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.build(endpoint, containerId),
      onSuccess: (response) {
        final deleted = response["deleted"] == true;

        if (deleted) {
          return;
        }
      },
    );
  }
}
