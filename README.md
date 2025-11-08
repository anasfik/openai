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
  dart_openai: ^6.0.0
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

| API feature | Status | Details |
|--------------|--------|----------|
| **📋 [Responses](#-responses)** | ✅ Complete | excluding stream functionality |
| **💭 [Conversations](#-conversations)** | ✅ Complete | All |
| **🎵 [Audio](#-audio)** | ✅ Complete | All |
| **🎬 [Videos](#-videos)** | 🗓️ planned | - |
| **🎨 [Images](#-images)** | ✅ Complete | All |
| **🎨 [Images Streaaming](#-images-streaaming)** | 🗓️ planned | - |
| **📊 [Embeddings](#-embeddings)** | ✅ Complete | All |
| **⚖️ [Evals](#️-evals)** | 🗓️ planned | - |
| **🔧 [Fine-tuning](#-fine-tuning)** | 🧩 70% Complete | missing newer endpoints |
| **📊 [Graders](#-graders)** | ✅ Complete | All |
| **📦 [Batch](#-batch)** | 🗓️ planned | - |
| **📁 [Files](#-files)** | ✅ Complete | All |
| **📤 [Uploads](#-uploads)** | 🗓️ planned | - |
| **🤖 [Models](#-models)** | ✅ Complete | All |
| **🛡️ [Moderation](#️-moderation)** | ✅ Complete | All|
| **🗃️ [Vector Stores](#️-vector-stores)** | 🗓️ planned  | - |
| **💬 ChatKit** | ❌ NOt planned  | Beta feature |
| **📦 [Containers](#-containers)** | 🗓️ planned  | - |
| **🕛 [Real-time](#-real-time)** | 🗓️ planned  | - |
| **💬 [Chat Completions](#-chat-completions)** | ✅ Complete | excluding stream functionality |
| **🤖 Assistants** | NOt planned | beta feature |
| **🤖 [Administration](#-administration)** | 🗓️ planned | - |
| **📝 Completions (Legacy)** | ✅ Complete | Create, Stream, Log probabilities |
| **✏️ Edits (Legacy)** | ✅ Complete | Text editing (deprecated by OpenAI) |

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

// Update response
OpenAIResponseModel updatedResponse = await OpenAI.instance.responses.update(
  "response-id",
  // ... update parameters
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

```

#### 💭 Conversations

```dart
// Create conversation
OpenAIConversation conversation = await OpenAI.instance.conversations.create(
  items: [
    // ...
  ],
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

// (To be implemented)

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
  purpose: OpenAIFilePurpose.fineTune,
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
// Create moderation
OpenAIModerationModel moderation = await OpenAI.instance.moderation.create(
  input: ["Text to classify for moderation"],
  model: "omni-moderation-latest",
);
```

#### 🗃️ Vector Stores

// (To be implemented)

#### 📦 Containers

// (To be implemented)

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
