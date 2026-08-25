import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dart_openai/src/core/models/fine_tuning/models.dart';
import 'package:dart_openai/src/core/networking/client.dart';

/// The new Fine-tuning API (`/fine_tuning/jobs`).
///
/// The legacy `/fine-tunes` API remains available via [OpenAIFineTunes] but
/// is deprecated by OpenAI.
class OpenAIFineTuning {
  final OpenAIClientConfig? _config;

  OpenAIFineTuning([this._config]);

  String get _endpoint => OpenAIStrings.endpoints.fineTuning;

  String get _jobs => '$_endpoint/jobs';

  /// Creates a fine-tuning job.
  Future<OpenAIFineTuningJob> create({
    required String model,
    required String trainingFile,
    String? validationFile,
    Map<String, dynamic>? hyperparameters,
    String? suffix,
    int? seed,
    Map<String, dynamic>? integrations,
  }) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, _jobs),
      body: {
        'model': model,
        'training_file': trainingFile,
        if (validationFile != null) 'validation_file': validationFile,
        if (hyperparameters != null) 'hyperparameters': hyperparameters,
        if (suffix != null) 'suffix': suffix,
        if (seed != null) 'seed': seed,
      },
      onSuccess: OpenAIFineTuningJob.fromMap,
      config: _config,
    );
  }

  /// Lists fine-tuning jobs.
  Future<OpenAIFineTuningJobList> list({String? after, int? limit}) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: _jobs,
        query: {
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
        },
        config: _config,
      ),
      onSuccess: OpenAIFineTuningJobList.fromMap,
      config: _config,
    );
  }

  /// Retrieves a job.
  Future<OpenAIFineTuningJob> retrieve({required String jobId}) async {
    return OpenAINetworkingClient.get(
      from: BaseApiUrlBuilder.buildFor(_config, _jobs, jobId),
      onSuccess: OpenAIFineTuningJob.fromMap,
      config: _config,
    );
  }

  /// Cancels a job.
  Future<OpenAIFineTuningJob> cancel({required String jobId}) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, '$_jobs/$jobId/cancel'),
      onSuccess: OpenAIFineTuningJob.fromMap,
      config: _config,
    );
  }

  /// Pauses a job.
  Future<OpenAIFineTuningJob> pause({required String jobId}) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, '$_jobs/$jobId/pause'),
      onSuccess: OpenAIFineTuningJob.fromMap,
      config: _config,
    );
  }

  /// Resumes a paused job.
  Future<OpenAIFineTuningJob> resume({required String jobId}) async {
    return OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.buildFor(_config, '$_jobs/$jobId/resume'),
      onSuccess: OpenAIFineTuningJob.fromMap,
      config: _config,
    );
  }

  /// Lists events for a job.
  Future<List<OpenAIFineTuningEvent>> listEvents({
    required String jobId,
    String? after,
    int? limit,
  }) async {
    return OpenAINetworkingClient.get<List<OpenAIFineTuningEvent>>(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: '$_jobs/$jobId/events',
        query: {
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
        },
        config: _config,
      ),
      onSuccess: (response) => (response['data'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(OpenAIFineTuningEvent.fromMap)
          .toList(),
      config: _config,
    );
  }

  /// Lists checkpoints for a job.
  Future<List<OpenAIFineTuningCheckpoint>> listCheckpoints({
    required String jobId,
    String? after,
    int? limit,
  }) async {
    return OpenAINetworkingClient.get<List<OpenAIFineTuningCheckpoint>>(
      from: BaseApiUrlBuilder.buildWithQuery(
        endpoint: '$_jobs/$jobId/checkpoints',
        query: {
          if (after != null) 'after': after,
          if (limit != null) 'limit': limit.toString(),
        },
        config: _config,
      ),
      onSuccess: (response) => (response['data'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(OpenAIFineTuningCheckpoint.fromMap)
          .toList(),
      config: _config,
    );
  }
}
