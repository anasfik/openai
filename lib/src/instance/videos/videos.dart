import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/io/openai_file.dart';
import 'package:dart_openai/src/core/models/videos/models.dart';
import 'package:dart_openai/src/core/networking/client.dart';

/// The Videos API (`/videos`).
///
/// Video creation is asynchronous: [create] returns a job whose [OpenAIVideoModel.status]
/// moves from `queued` to `in_progress` to `completed` (or `failed`). Poll with
/// [retrieve] until completed, then fetch the MP4 bytes via [downloadContent].
class OpenAIVideos {
  final OpenAIClientConfig? _config;

  OpenAIVideos([this._config]);

  String get _endpoint => OpenAIStrings.endpoints.videos;

  /// Creates a video generation job. The response reflects the queued job,
  /// not a finished video.
  Future<OpenAIVideoModel> create({
    required String model,
    required String prompt,
    String? seconds,
    String? size,
    String? inputReference,
  }) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, _endpoint),
      body: {
        'model': model,
        'prompt': prompt,
        if (seconds != null) 'seconds': seconds,
        if (size != null) 'size': size,
        if (inputReference != null) 'input_reference': inputReference,
      },
      onSuccess: OpenAIVideoModel.fromMap,
      config: _config,
    );
  }

  /// Lists video jobs.
  Future<OpenAIVideoList> list({String? after, int? limit}) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: _endpoint,
        query: {
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
        },
        config: _config,
      ),
      onSuccess: OpenAIVideoList.fromMap,
      config: _config,
    );
  }

  /// Retrieves a video job.
  Future<OpenAIVideoModel> retrieve({required String videoId}) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint, videoId),
      onSuccess: OpenAIVideoModel.fromMap,
      config: _config,
    );
  }

  /// Deletes a video job.
  Future<OpenAIVideoModel> delete({required String videoId}) async {
    return OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint, videoId),
      onSuccess: OpenAIVideoModel.fromMap,
      config: _config,
    );
  }

  /// Remixes an existing video with a new prompt.
  Future<OpenAIVideoModel> remix({
    required String videoId,
    required String prompt,
  }) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/$videoId/remix'),
      body: {'prompt': prompt},
      onSuccess: OpenAIVideoModel.fromMap,
      config: _config,
    );
  }

  /// Downloads the generated MP4 content of a completed video.
  ///
  /// Returns the raw response body as a base64 string of the MP4 bytes;
  /// decode with `base64.decode(...)` to obtain the file bytes.
  Future<String> downloadContent({required String videoId}) async {
    return OpenAINetworkingClient.get<String>(
      from: BaseApiUrlBuilder.buildFor(_config, _endpoint, '$videoId/content'),
      returnRawResponse: true,
      config: _config,
    );
  }

  /// Edits an existing video with a prompt, uploading the source video as a
  /// multipart file (`POST /videos/edits`).
  Future<OpenAIVideoModel> createEdit({
    required String model,
    required String prompt,
    required OpenAIFile video,
    String? seconds,
    String? size,
  }) async {
    return OpenAINetworkingClient.fileUpload<OpenAIVideoModel>(
      to: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/edits'),
      body: {
        'model': model,
        'prompt': prompt,
        if (seconds != null) 'seconds': seconds,
        if (size != null) 'size': size,
      },
      file: video,
      fileField: 'video',
      onSuccess: OpenAIVideoModel.fromMap,
      config: _config,
    );
  }

  /// Extends a video with a new prompt, uploading the source video as a
  /// multipart file (`POST /videos/extensions`).
  Future<OpenAIVideoModel> createExtension({
    required String prompt,
    required OpenAIFile video,
    String? seconds,
    String? size,
  }) async {
    return OpenAINetworkingClient.fileUpload<OpenAIVideoModel>(
      to: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/extensions'),
      body: {
        'prompt': prompt,
        if (seconds != null) 'seconds': seconds,
        if (size != null) 'size': size,
      },
      file: video,
      fileField: 'video',
      onSuccess: OpenAIVideoModel.fromMap,
      config: _config,
    );
  }

  /// Lists video characters (`GET /videos/characters`). Raw response map.
  Future<Map<String, dynamic>> listCharacters() async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/characters'),
      onSuccess: (response) => response,
      config: _config,
    );
  }

  /// Retrieves a video character (`GET /videos/characters/{id}`).
  /// Raw response map.
  Future<Map<String, dynamic>> retrieveCharacter({
    required String characterId,
  }) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/characters', characterId),
      onSuccess: (response) => response,
      config: _config,
    );
  }

  /// Deletes a video character (`DELETE /videos/characters/{id}`).
  /// Raw response map.
  Future<Map<String, dynamic>> deleteCharacter({
    required String characterId,
  }) async {
    return OpenAINetworkingClient.delete(
      from: BaseApiUrlBuilder.buildFor(_config, '$_endpoint/characters', characterId),
      onSuccess: (response) => response,
      config: _config,
    );
  }
}
