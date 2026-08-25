import 'package:dart_openai/src/core/config/client_config.dart';
import 'package:dart_openai/src/instance/audio/audio.dart';
import 'package:dart_openai/src/instance/batch/batch.dart';
import 'package:dart_openai/src/instance/chat/chat.dart';
import 'package:dart_openai/src/instance/completion/completion.dart';
import 'package:dart_openai/src/instance/containers/container.dart';
import 'package:dart_openai/src/instance/conversations/conversations.dart';
import 'package:dart_openai/src/instance/edits/edits.dart';
import 'package:dart_openai/src/instance/embedding/embedding.dart';
import 'package:dart_openai/src/instance/evals/evals.dart';
import 'package:dart_openai/src/instance/files/files.dart';
import 'package:dart_openai/src/instance/fine_tunes/fine_tunes.dart';
import 'package:dart_openai/src/instance/fine_tuning/fine_tuning.dart';
import 'package:dart_openai/src/instance/graders/graders.dart';
import 'package:dart_openai/src/instance/images/images.dart';
import 'package:dart_openai/src/instance/model/model.dart';
import 'package:dart_openai/src/instance/moderations/moderations.dart';
import 'package:dart_openai/src/instance/organization/organization.dart';
import 'package:dart_openai/src/instance/provenance/provenance.dart';
import 'package:dart_openai/src/instance/realtime/realtime.dart';
import 'package:dart_openai/src/instance/skills/skills.dart';
import 'package:dart_openai/src/instance/videos/videos.dart';
import 'package:dart_openai/src/instance/responses/responses.dart';
import 'package:dart_openai/src/instance/uploads/uploads.dart';
import 'package:dart_openai/src/instance/vector_stores/vector_stores.dart';

/// An isolated OpenAI API client.
///
/// Unlike the legacy global facade (`OpenAI.apiKey = ...`), each [OpenAIClient]
/// owns its configuration, so you can talk to multiple accounts, Azure
/// resources, or OpenAI-compatible providers in the same app:
///
/// ```dart
/// final openai = OpenAIClient(apiKey: 'sk-...');
/// final chat = await openai.chat.create(model: 'gpt-4o', messages: [...]);
///
/// final deepseek = OpenAIClient(
///   apiKey: 'ds-...',
///   baseUrl: 'https://api.deepseek.com',
/// );
/// ```
class OpenAIClient {
  /// The configuration used by every endpoint of this client.
  final OpenAIClientConfig config;

  /// Creates a client with its own [config].
  OpenAIClient({
    String? apiKey,
    String? organization,
    String? baseUrl,
    String? version,
    Duration? requestsTimeOut,
    Map<String, dynamic>? extraHeaders,
  }) : config = OpenAIClientConfig(
          apiKey: apiKey,
          organization: organization,
          baseUrl: baseUrl ?? 'https://api.openai.com',
          version: version ?? 'v1',
          requestsTimeOut: requestsTimeOut ?? const Duration(seconds: 30),
          extraHeaders: extraHeaders ?? const {},
        );

  /// Creates a client from an existing [OpenAIClientConfig].
  const OpenAIClient.fromConfig(this.config);

  /// Models endpoints.
  OpenAIModel get model => OpenAIModel(config);

  /// Completions endpoints (legacy).
  OpenAICompletion get completion => OpenAICompletion(config);

  /// Edits endpoints (deprecated by OpenAI).
  OpenAIEdits get edit => OpenAIEdits(config);

  /// Images endpoints.
  OpenAIImages get image => OpenAIImages(config);

  /// Embeddings endpoints.
  OpenAIEmbedding get embedding => OpenAIEmbedding(config);

  /// Evals endpoints.
  OpenAIEvals get evals => OpenAIEvals(config);

  /// Grader factories and helpers.
  OpenAIGraders get graders => OpenAIGraders();

  /// Batch endpoints.
  OpenAIBatch get batch => OpenAIBatch(config);

  /// Files endpoints.
  OpenAIFiles get file => OpenAIFiles(config);

  /// Uploads endpoints.
  OpenAIUploads get uploads => OpenAIUploads(config);

  /// Fine-tunes endpoints (legacy API).
  OpenAIFineTunes get fineTune => OpenAIFineTunes(config);

  /// Fine-tuning jobs (current API).
  OpenAIFineTuning get fineTuning => OpenAIFineTuning(config);

  /// Moderations endpoints.
  OpenAIModeration get moderation => OpenAIModeration(config);

  /// Vector stores endpoints.
  OpenAIVectorStores get vectorStores => OpenAIVectorStores(config);

  /// Containers endpoints.
  OpenAIContainerContainers get container => OpenAIContainerContainers(config);

  /// Chat completions endpoints.
  OpenAIChat get chat => OpenAIChat(config);

  /// Audio endpoints.
  OpenAIAudio get audio => OpenAIAudio(config);

  /// Responses endpoints.
  OpenAIResponses get responses => OpenAIResponses(config);

  /// Conversations endpoints.
  OpenAIConversations get conversations => OpenAIConversations(config);

  /// Realtime REST endpoints (sessions and ephemeral client secrets).
  OpenAIRealtime get realtime => OpenAIRealtime(config);

  /// Videos endpoints.
  OpenAIVideos get videos => OpenAIVideos(config);

  /// Skills endpoints.
  OpenAISkills get skills => OpenAISkills(config);

  /// Content provenance checks.
  OpenAIProvenance get provenance => OpenAIProvenance(config);

  /// Organization administration endpoints.
  OpenAIOrganization get organization => OpenAIOrganization(config);
}
