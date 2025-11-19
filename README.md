# 🚀 Dart OpenAI

<div align="center">

[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/anasfik/openai)](https://github.com/anasfik/openai)
[![GitHub contributors](https://img.shields.io/github/contributors/anasfik/openai)](https://github.com/anasfik/openai/graphs/contributors)
[![GitHub Repo stars](https://img.shields.io/github/stars/anasfik/openai?style=social)](https://github.com/anasfik/openai)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/anasfik/openai/dart.yml?label=tests)](https://github.com/anasfik/openai/actions)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/anasfik/openai/release.yml?label=build)](https://github.com/anasfik/openai/actions)
[![GitHub](https://img.shields.io/github/license/anasfik/openai)](https://github.com/anasfik/openai/blob/main/LICENSE)
[![Pub Version](https://img.shields.io/pub/v/dart_openai)](https://pub.dev/packages/dart_openai)
[![Pub Likes](https://img.shields.io/pub/likes/dart_openai)](https://pub.dev/packages/dart_openai)
[![Pub Points](https://img.shields.io/pub/points/dart_openai)](https://pub.dev/packages/dart_openai)
[![Pub Popularity](https://img.shields.io/pub/popularity/dart_openai)](https://pub.dev/packages/dart_openai)

**A comprehensive Dart/Flutter client for OpenAI's powerful AI models**

[Quick Start](#-quick-start) • [Documentation](#-documentation) • [Examples](#-examples) • [API Coverage](#-api-coverage) • [Contributing](#-contributing)

</div>

---

## ✨ Overview

Dart OpenAI is an **unofficial** but comprehensive client package that allows developers to easily integrate OpenAI's state-of-the-art AI models into their Dart/Flutter applications. The package provides simple, intuitive methods for making requests to OpenAI's various APIs, including GPT models, DALL-E image generation, Whisper audio processing, and more.

> **⚠️ Note**: This is an **unofficial** package. OpenAI does not have an official Dart library.

### 🎯 Key Features

- 🚀 **Easy Integration** - Simple, intuitive API that mirrors OpenAI's documentation
- 🔐 **Secure Authentication** - One-time setup, use anywhere in your application
- 📡 **Streaming Support** - Real-time streaming for completions, chat, and fine-tune events
- 🛠️ **Developer Friendly** - Comprehensive error handling and logging
- 📚 **Rich Examples** - Ready-to-use examples for every implemented feature
- 🎨 **Modern UI Support** - Optimized for Flutter applications
- 🔄 **Custom APIs** - Additional custom endpoints for enhanced functionality

---

## 🚀 Quick Start

### Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  dart_openai: 
```

### Basic Setup

```dart
import 'package:dart_openai/dart_openai.dart';

void main() {
  // Set your API key
  OpenAI.apiKey = "your-api-key-here";
  
  // Optional: Set organization ID
  OpenAI.organization = "your-org-id";
  
  // Optional: Configure timeout
  OpenAI.requestsTimeOut = Duration(seconds: 60);
  
  // Optional: Enable logging
  OpenAI.showLogs = true;
  
  runApp(MyApp());
}
```

### Your First API Call

```dart
// Simple chat completion
final chatCompletion = await OpenAI.instance.chat.create(
  model: "gpt-3.5-turbo",
  messages: [
    OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.user,
      content: "Hello, how are you?",
    ),
  ],
);

print(chatCompletion.choices.first.message.content);
```

---

## 📊 API Coverage (2025)

| API feature | Status | Details | Last Updated |
|--------------|--------|----------| --------------|
| **📋 [Responses](#-responses)** | ✅ Complete | All |  11-08-2025 17:33:39 |
| **💭 [Conversations](#-conversations)** | ✅ Complete | All | 11-08-2025 17:38:56 |
| **🎵 [Audio](#-audio)** | ✅ Complete | All | 11-08-2025 17:42:54 |
| **🎬 [Videos](#-videos)** | 🗓️ planned | - ||
| **🎨 [Images](#-images)** | ✅ Complete | All |  11-08-2025 17:53:45 |
| **🎨 [Images Streaaming](#-images-streaaming)** | 🗓️ planned | - ||
| **📊 [Embeddings](#-embeddings)** | ✅ Complete | All |  11-08-2025 17:56:30 |
| **⚖️ [Evals](#️-evals)** | ✅ Complete | All |  11-08-2025 21:04:36 |
| **🔧 [Fine-tuning](#-fine-tuning)** | 🧩 70% Complete | missing newer endpoints ||
| **📊 [Graders](#-graders)** | ✅ Complete | All |  11-08-2025 21:46:48 |
| **📦 [Batch](#-batch)** | 🗓️ planned | - ||
| **📁 [Files](#-files)** | ✅ Complete | All | 11-08-2025 21:51:34|
| **📤 [Uploads](#-uploads)** | 🗓️ planned | - ||
| **🤖 [Models](#-models)** | ✅ Complete | All | 11-08-2025 21:53:13 |
| **🛡️ [Moderation](#️-moderation)** | ✅ Complete | All |  11-08-2025 21:54:01 |
| **🗃️ [Vector Stores](#️-vector-stores)** | ✅ Complete | All | 11-19-2025 12:24:15 |
| **💬 ChatKit** | ❌ Not planned  | Beta feature ||
| **📦 [Containers](#containers)** | ✅ Complete | All | 11-19-2025 12:24:15 |
| **🕛 [Real-time](#-real-time)** | 🗓️ planned  | - ||
| **💬 [Chat Completions](#-chat-completions)** | ✅ Complete | excluding stream functionality ||
| **🤖 Assistants** | ❌ Not planned | beta feature ||
| **🤖 [Administration](#-administration)** | 🗓️ planned | - ||
| **📝 Completions (Legacy)** | ✅ Complete | All ||
| **✏️ Edits (Legacy)** | ✅ Complete | All ||

---

## 📚 Documentation

### Core APIs

#### 📋 Responses

```dart
// Create response
OpenAiResponse response = await OpenAI.instance.responses.create(
  input: "Your input text here",  
  model: "gpt-4",
);

// Get response
OpenAiResponse response = await OpenAI.instance.responses.get(
  responseId: "response-id-here",
  startingAfter: 0, 
);

// Delete response
await OpenAI.instance.responses.delete(
  responseId: "response-id-here",
);

// Cancel response
OpenAiResponse response = await OpenAI.instance.responses.cancel(
  responseId: "response-id-here",
);

// list input items
OpenAiResponseInputItemsList response = await OpenAI.instance.responses.listInputItems(
  responseId: "response-id-here",
  limit: 10, 
);


// Get input token counts
int inputTokens = await OpenAI.instance.responses.getInputTokenCounts(
  model: "gpt-5",
  input: "Your input text here",
);
```

#### 💭 Conversations

```dart
// Create conversation
OpenAIConversation conversation = await OpenAI.instance.conversations.create(
  items: [{
    "type": "message",
    "role": "user",
    "content": "Hello!",
  }],
  metadata: {
    "key": "value",
    "another_key": "another_value",
  },
);


// Get conversation
OpenAIConversation conversation = await OpenAI.instance.conversations.get(
  conversationId: "conversation-id-here",
);

// Update conversation
OpenAIConversation updatedConversation = await OpenAI.instance.conversations.update(
  conversationId: "conversation-id",
  metadata: {
    "key": "new_value",
  },
);

// Delete conversation
 await OpenAI.instance.conversations.delete(
  conversationId: "conversation-id-here",
);

// list items
OpenAIConversationItemsResponse itemsList = await OpenAI.instance.conversations.listItems(
  conversationId: "conversation-id-here",
  limit: 10, 
);

// Create item
OpenAIConversationItem item = await OpenAI.instance.conversations.createItems(
  conversationId: "conversation-id-here",
  items: [
    // ...
  ],
);

// get item
OpenAIConversationItem item = await OpenAI.instance.conversations.getItem(
  conversationId: "conversation-id-here",
  itemId: "item-id-here",
);

// delete item
await OpenAI.instance.conversations.deleteItem(
  conversationId: "conversation-id-here",
  itemId: "item-id-here",
);
```

#### 🎵 Audio

```dart
// Create speech
File speechFile = await OpenAI.instance.audio.createSpeech(
  model: "tts-1",
  input: "Text to convert to speech",
  voice: OpenAIAudioVoice.fable,
  responseFormat: OpenAIAudioSpeechResponseFormat.mp3,
  outputDirectory: "/path/to/output/directory",
  outputFileName: "output_speech.mp3",
);


// Transcribe audio
OpenAITranscriptionGeneralModel transcription = await OpenAI.instance.audio.createTranscription(
  model: "whisper-1",
  file: File("path/to/audio.mp3"),
  include: ["logprobs"],
  responseFormat: OpenAIAudioResponseFormat.verbose_json,
  language: "en",
  prompt: "This is a sample prompt to guide transcription",
);
// Handling different transcription response formats
if (transcription is OpenAITranscriptionModel) {
  print(transcription.logprobs);
  print(transcription.text);
  print(transcription.usage);
} else if (transcription is OpenAITranscriptionVerboseModel) {
  // print the transcription.
  print(transcription.text);
  print(transcription.segments?.map((e) => e.end));
}

// Create Translation
final translationText = await OpenAI.instance.audio.createTranslation(
  file: File("path/to/audio.mp3"),
  model: "whisper-1",
  prompt: "use unusual english words",
  responseFormat: OpenAIAudioResponseFormat.json,
);

```

#### 🎬 Videos

// (To be implemented)

#### 🎨 Images

```dart
// Generate image
OpenAIImageModel image = await OpenAI.instance.image.create(
  model: "dall-e-3",
  prompt: "image of a cat in a spaceship",
  responseFormat: OpenAIImageResponseFormat.url,
  size: OpenAIImageSize.size1024,
  quality: OpenAIImageQuality.standard,
  style: OpenAIImageStyle.vivid,
);

// Edit image
OpenAIImageModel imageEdit = await OpenAI.instance.image.edit(
  prompt: 'A fantasy landscape with mountains and a river',
  image: File("path/to/image.png"),
  size: OpenAIImageSize.size1024,
  responseFormat: OpenAIImageResponseFormat.b64Json,
);

// Create variation
List<OpenAIImageModel> imageVariation = await OpenAI.instance.image.variation(
  model: "dall-e-2",
  image: File("path/to/image.png"),
  size: OpenAIImageSize.size512,
  responseFormat: OpenAIImageResponseFormat.url,
);
```

#### 🎨 Images Streaaming

// (To be implemented)

#### 📊 Embeddings

```dart
OpenAIEmbeddingsModel embedding = await OpenAI.instance.embedding.create(
  model: "text-embedding-ada-002",
  input: "This is a sample text",
);
```

#### ⚖️ Evals

```dart
// Create eval
OpenAIEval eval = await OpenAI.instance.evals.create(
  dataSourceConfig: RequestDatatSourceConfig.logs(),
);

// Get eval
OpenAIEval eval = await OpenAI.instance.evals.get(
  evalId: "eval-id-here",
);

// Update eval
OpenAIEval updatedEval = await OpenAI.instance.evals.update(
  evalId: "eval-id-here",
  metadata: {
    "key": "new_value",
  },
);

// Delete eval
 await OpenAI.instance.evals.delete(
  evalId: "eval-id-here",
);

// List evals
OpenAIEvalsList evalsList = await OpenAI.instance.evals.list(
  limit: 10, 
);

// Get eval runs.
OpenAIEvalRunsList evalRuns = await OpenAI.instance.evals.getRuns(
  evalId: "eval-id-here",
  limit: 3, 
);

// Get Eval run
OpenAIEvalRun evalRun = await OpenAI.instance.evals.getRun(
  evalId: "eval-id-here",
  runId: "run-id-here",
);

// Create run
OpenAIEvalRun createdRun = await OpenAI.instance.evals.createRun(
  evalId: "eval-id-here",
  dataSource: EvalRunDataSource.jsonl(),
);

// Cancel run
OpenAIEvalRun canceledRun = await OpenAI.instance.evals.cancel(
  evalId: "eval-id-here",
  runId: "run-id-here",
);

// Delete run
 await OpenAI.instance.evals.deleteRun(
  evalId: "eval-id-here",
  runId: "run-id-here",
);

// Get output item of eval run.
OpenAIEvalRunOutputItem outputItem = await OpenAI.instance.evals.getEvalRunOutputItem(
  evalId: "eval-id-here",
  runId: "run-id-here",
  outputItemIdn: "item-id-here",
);

// Get eval run output items.
OpenAIEvalRunOutputItemsList outputItems = await OpenAI.instance.evals.getEvalRunOutputItems(
  evalId: "eval-id-here",
  runId: "run-id-here",
  limit: 10,
);
```

#### 🔧 Fine-tuning

// (To be implemented)

#### 📊 Graders

```dart

// graders
final grader = OpenAIGraders.stringCheckGrader(...);
final grader2 = OpenAIGraders.textSimilarityGrader(...);
final grader3 = OpenAIGraders.scoreModelGrader(...);
final grader4 = OpenAIGraders.labelModelGrader(...);
final grader5 = OpenAIGraders.pythonGrader(...);
final grader6 = OpenAIGraders.multiGrader(...);

// Run grader
final grader = await OpenAI.instance.graders.runGrader(
 grader: grader,
 modelSample: "The model output to be graded", 
);

// Validate Grader
final isValid = OpenAI.instance.graders.validateGrader(
  grader: grader
);
```

#### 📦 Batch

// (To be implemented)

#### 📁 Files

```dart
// Upload file
OpenAIFileModel file = await OpenAI.instance.files.upload(
  file: File("path/to/file.jsonl"),
  purpose: "assistants",
);

// List files
List<OpenAIFileModel> files = await OpenAI.instance.files.list(
  limit: 10,
);

// Retrieve file
OpenAIFileModel file = await OpenAI.instance.files.retrieve(
   "file_id" 
);

// Delete file
await OpenAI.instance.files.delete("file-id-here");

// Retrieve file content
final content = await OpenAI.instance.files.retrieveContent(
  "file_id"
);
```

#### 📤 Uploads

// (To be implemented)

#### 🤖 Models

```dart
// List all available models
List<OpenAIModelModel> models = await OpenAI.instance.model.list();

// Retrieve specific model
OpenAIModelModel model = await OpenAI.instance.model.retrieve("gpt-3.5-turbo");

// Delete fine-tuned model
bool deleted = await OpenAI.instance.model.delete("fine-tuned-model-id");
```

#### 🛡️ Moderation

```dart
OpenAIModerationModel moderation = await OpenAI.instance.moderation.create(
  input: ["Text to classify for moderation"],
  model: "omni-moderation-latest",
);
```

#### 🗃️ Vector Stores

##### Vector Stores

```dart
// Create vector store
  OpenAIVectorStoreModel vectorStore = await OpenAI.instance.vectorStores.vectorStores.create(
    name: "example_vector_store",
    chunkingStrategy: OpenAIVectorStoreChunkingStrategy.static(
      chunkOverlapTokens: 300,
      maxChunkSizeTokens: 750,
    ),
    expiresAfter: OpenAIVectorStoreExpiresAfter(
      anchor: "last_active_at",
      days: 1,
    ),
  ); 

  // List vector stores
 OpenAIVectorStoreListModel allVEctorStores = await OpenAI.instance.vectorStores.vectorStores.list(limit: 30);

 // Get vector store
 final firstVectorStoreAsync = await OpenAI.instance.vectorStores.vectorStores.get(
   vectorStoreId: "vector_store_id",
 );

// Modify vector store
final updatedVectorStore = await OpenAI.instance.vectorStores.vectorStores.modify(
  vectorStoreId: "vector_store_id",
  name: "updated_vector_store_name",
);

// Delete vector store
await OpenAI.instance.vectorStores.vectorStores.delete(
  vectorStoreId: "vector_store_id",
);

// search in vector store
final searchVEctorStoreResult = await OpenAI.instance.vectorStores.vectorStores.search(
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

```

##### Vector store files

```dart

// Create vector store file
final createdVectorStoreFile = await OpenAI.instance.vectorStores.vectorStoresFiles.create(
  vectorStoreId: "vector_store_id",
  fileId: "file_id",
  attributes: {
    "chapter": "Chapter 1",
  },
  chunckingStrategy: OpenAIVectorStoreChunkingStrategy.static(
    chunkOverlapTokens: 300,
    maxChunkSizeTokens: 750,
  ),
);

// List vector store files
final vectorStoreFiles = await OpenAI.instance.vectorStores.vectorStoresFiles.list(
  vectoreStoreId: "vector_store_id",
  limit: 60,
);

// Get vector store file
final vectorStoreFile = await OpenAI.instance.vectorStores.vectorStoresFiles.get(
  fileId: "file_id",
  vectorStoreId: "vector_store_id",
);

// Get vector store file content
final vectorStoreFileContent = await OpenAI.instance.vectorStores.vectorStoresFiles.getContent(
  fileId: "file_id",
  vectorStoreId: "vector_store_id",
);

// Update vector store file
final updatedVectorStoreFile = await OpenAI.instance.vectorStores.vectorStoresFiles.update(
  fileId: "file_id",
  vectorStoreId: "vector_store_id",
  attributes: {
    "chapter": "Updated Chapter 1",
  },
);

// Delete vector store file
await OpenAI.instance.vectorStores.vectorStoresFiles.delete(
  fileId: "file_id",
  vectorStoreId: "vector_store_id",
);

```

##### Vector store file batches

```dart

// Create vector store file batch
final vectoreStoreFileBatch = await OpenAI.instance.vectorStores.vectorStoreFileBatch.create(
  vectorStoreId: "vector_store_id",
  chunkingStrategy: OpenAIVectorStoreChunkingStrategy.static(
    chunkOverlapTokens: 200,
    maxChunkSizeTokens: 550,
  ),
  attributes: {
    "batch_name": "My First Batch",
  },
  fileIds: ["file-abc123", "file-def456"],
);

// Get vector store file batch
final batch = await OpenAI.instance.vectorStores.vectorStoreFileBatch.get(
  batchId: "batch_id",
  vectorStoreId: "vector_store_id",
);

// Cancel vector store file batch
final cancelledBatch = await OpenAI.instance.vectorStores.vectorStoreFileBatch.cancel(
  batchId: "batch_id",
  vectorStoreId: "vector_store_id",
);

// List vector store files in a batch
final vectorStoreBatchFiles = await OpenAI.instance.vectorStores.vectorStoreFileBatch.list(
  vectorStoreId: "vector_store_id",
  batchId: 'batch_id',
);

```

#### 📦 Containers

##### Containers

```dart
// Create container
final container = await OpenAI.instance.container.containers.create(
  name: "my special container",
);

// List containers
final containers = await OpenAI.instance.container.containers.list(
  limit: 20,
);

// Get container
final firstContainer = await OpenAI.instance.container.containers.get(
  containerId: "container_id",
);

// Delete container
await OpenAI.instance.container.containers.delete(
  containerId: "container_id",
);

```

##### Container Files

```dart
// Create container file
final containerFile = await OpenAI.instance.container.containerFiles.create(
  file: File("path/to/file"),
  containerId: "container_id",
);

// Get container file
final gotContainerFile = await OpenAI.instance.container.containerFiles.get(
  containerId: "container_id",
  fileId: "file_id",
);

// Get container file content
final gotContainerFileContent =
    await OpenAI.instance.container.containerFiles.getContent(
  containerId: "container_id",
  fileId: "file_id",
);

// List container files
final allContainerFiles = await OpenAI.instance.container.containerFiles.list(
  containerId: "container_id",
  limit: 20,
);

// Delete container file
await OpenAI.instance.container.containerFiles.delete(
  fileId: "file_id",
  containerId: "container_id",
);

```


#### 🕛 Real-time

// (To be implemented)

#### 💬 Chat Completions

```dart
// Basic chat completion
OpenAIChatCompletionModel chat = await OpenAI.instance.chat.create(
  model: "gpt-3.5-turbo",
  messages: [
    OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.user,
      content: "Hello, how can you help me?",
    ),
  ],
  temperature: 0.7,
  maxTokens: 150,
);

// Streaming chat completion
Stream<OpenAIStreamChatCompletionModel> chatStream = OpenAI.instance.chat.createStream(
  model: "gpt-3.5-turbo",
  messages: [
    OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.user,
      content: "Tell me a story",
    ),
  ],
);

chatStream.listen((event) {
  print(event.choices.first.delta.content);
});
```

#### 🤖 Administration

// (To be implemented)

---


## 🔧 Configuration

### Environment Variables

```dart
// Using envied package
@Envied(path: ".env")
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_API_KEY')
  static const apiKey = _Env.apiKey;
}

void main() {
  OpenAI.apiKey = Env.apiKey;
  runApp(MyApp());
}
```

### Custom Configuration

```dart
void main() {
  // Set API key
  OpenAI.apiKey = "your-api-key";
  
  // Set organization (optional)
  OpenAI.organization = "your-org-id";
  
  // Set custom base URL (optional)
  OpenAI.baseUrl = "https://api.openai.com/v1";
  
  // Set request timeout (optional)
  OpenAI.requestsTimeOut = Duration(seconds: 60);
  
  // Enable logging (optional)
  OpenAI.showLogs = true;
  OpenAI.showResponsesLogs = true;
  
  runApp(MyApp());
}
```

---

## 🚨 Error Handling

```dart
try {
  final chat = await OpenAI.instance.chat.create(
    model: "gpt-3.5-turbo",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        role: OpenAIChatMessageRole.user,
        content: "Hello",
      ),
    ],
  );
} on RequestFailedException catch (e) {
  print("Request failed: ${e.message}");
  print("Status code: ${e.statusCode}");
} on MissingApiKeyException catch (e) {
  print("API key not set: ${e.message}");
} on UnexpectedException catch (e) {
  print("Unexpected error: ${e.message}");
}
```

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### 🐛 Bug Reports

- Use [GitHub Issues](https://github.com/anasfik/openai/issues) to report bugs
- Include reproduction steps and environment details

### 💡 Feature Requests

- Suggest new features via [GitHub Issues](https://github.com/anasfik/openai/issues)
- Check existing issues before creating new ones

### 🔧 Code Contributions

- Fork the repository
- Create a feature branch
- Make your changes
- Add tests if applicable
- Submit a pull request

### 📚 Documentation

- Help improve documentation
- Add examples for missing features
- Fix typos and improve clarity

### 💰 Sponsoring

- [Sponsor the project](https://github.com/sponsors/anasfik)
- Help maintain and improve the package

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **OpenAI** for providing the amazing AI models and APIs
- **Contributors** who help maintain and improve this package
- **Sponsors** who support the project financially
- **Community** for feedback and suggestions

---

## 📞 Support

- 📖 [Full Documentation](https://pub.dev/documentation/dart_openai/latest/)
- 🐛 [Report Issues](https://github.com/anasfik/openai/issues)
- 💬 [Discussions](https://github.com/anasfik/openai/discussions)
- 📧 [Contact](https://github.com/anasfik)

---

<div align="center">


**Made with ❤️ by the Dart OpenAI community**

[⭐ Star this repo](https://github.com/anasfik/openai) • [🐛 Report Bug](https://github.com/anasfik/openai/issues) • [💡 Request Feature](https://github.com/anasfik/openai/issues) • [📖 Documentation](https://pub.dev/documentation/dart_openai/latest/)

</div>
