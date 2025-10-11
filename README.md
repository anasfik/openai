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

## 📊 API Coverage

### ✅ Fully Implemented (100%)

| API Category | Status | Features |
|--------------|--------|----------|
| **🤖 Models** | ✅ Complete | List, Retrieve, Delete fine-tuned models |
| **💬 Chat Completions** | ✅ Complete | Create, Stream, Tools/Functions, Vision, JSON Mode |
| **📝 Completions** | ✅ Complete | Create, Stream, Log probabilities |
| **🎨 Images** | ✅ Complete | Generate, Edit, Variations |
| **🎵 Audio** | ✅ Complete | Speech, Transcription, Translation |
| **📁 Files** | ✅ Complete | Upload, List, Retrieve, Delete, Content |
| **🔧 Fine-tunes (Legacy)** | ✅ Complete | Create, List, Retrieve, Cancel, Events, Stream |
| **🛡️ Moderation** | ✅ Complete | Content policy classification |
| **✏️ Edits** | ✅ Complete | Text editing (deprecated by OpenAI) |

### 🔧 Custom APIs (100% Implemented)

| API Category | Status | Description |
|--------------|--------|-------------|
| **📋 Responses** | ✅ Complete | Custom response management system |
| **💭 Conversations** | ✅ Complete | Custom conversation handling |
| **📊 Graders** | ✅ Complete | Custom grading system |
| **📤 Uploads** | ✅ Complete | Custom upload management |

### ⚠️ Stub Implementations (Need Real Implementation)

| API Category | Status | Priority |
|--------------|--------|----------|
| **📊 Evals** | ⚠️ Stub | High - All methods throw `UnimplementedError` |
| **📦 Batch** | ⚠️ Stub | High - All methods throw `UnimplementedError` |
| **🗃️ Vector Stores** | ⚠️ Stub | High - All methods throw `UnimplementedError` |

### ❌ Missing APIs (Not Implemented)

| API Category | Status | Priority |
|--------------|--------|----------|
| **🤖 Assistants** | ❌ Missing | Critical - Core AI assistant functionality |
| **🧵 Threads** | ❌ Missing | Critical - Conversation management |
| **💬 Messages** | ❌ Missing | Critical - Message handling within threads |
| **🏃 Runs** | ❌ Missing | Critical - Assistant execution |
| **🔧 Fine-tuning (New)** | ❌ Missing | High - New fine-tuning API |
| **🛠️ Tools** | ❌ Missing | Medium - Tool management |
| **📋 Run Steps** | ❌ Missing | Medium - Run step tracking |
| **📎 Message Files** | ❌ Missing | Medium - File attachments in messages |

---

## 📚 Documentation

### Core APIs

#### 🤖 Models
```dart
// List all available models
List<OpenAIModelModel> models = await OpenAI.instance.model.list();

// Retrieve specific model
OpenAIModelModel model = await OpenAI.instance.model.retrieve("gpt-3.5-turbo");

// Delete fine-tuned model
bool deleted = await OpenAI.instance.model.delete("fine-tuned-model-id");
```

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

#### 🎨 Images
```dart
// Generate image
OpenAIImageModel image = await OpenAI.instance.image.create(
  prompt: "A beautiful sunset over mountains",
  n: 1,
  size: OpenAIImageSize.size1024,
  responseFormat: OpenAIImageResponseFormat.url,
);

// Edit image
OpenAIImageModel editedImage = await OpenAI.instance.image.edit(
  prompt: "Add a rainbow to the sky",
  image: File("path/to/image.png"),
  mask: File("path/to/mask.png"),
  n: 1,
  size: OpenAIImageSize.size1024,
);

// Create variation
OpenAIImageModel variation = await OpenAI.instance.image.variation(
  image: File("path/to/image.png"),
  n: 3,
  size: OpenAIImageSize.size512,
);
```

#### 🎵 Audio
```dart
// Create speech
File speechFile = await OpenAI.instance.audio.createSpeech(
  model: "tts-1",
  input: "Hello, this is a test",
  voice: "nova",
  responseFormat: OpenAIAudioSpeechResponseFormat.mp3,
  outputDirectory: Directory("output"),
  outputFileName: "speech",
);

// Transcribe audio
OpenAIAudioModel transcription = await OpenAI.instance.audio.createTranscription(
  file: File("path/to/audio.mp3"),
  model: "whisper-1",
  responseFormat: OpenAIAudioResponseFormat.json,
);

// Translate audio
OpenAIAudioModel translation = await OpenAI.instance.audio.createTranslation(
  file: File("path/to/audio.mp3"),
  model: "whisper-1",
  responseFormat: OpenAIAudioResponseFormat.text,
);
```

### Custom APIs

#### 📋 Responses API
```dart
// Create response
OpenAIResponseModel response = await OpenAI.instance.responses.create(
  // ... response parameters
);

// List responses
List<OpenAIResponseModel> responses = await OpenAI.instance.responses.list();

// Retrieve response
OpenAIResponseModel response = await OpenAI.instance.responses.retrieve("response-id");

// Update response
OpenAIResponseModel updatedResponse = await OpenAI.instance.responses.update(
  "response-id",
  // ... update parameters
);

// Delete response
bool deleted = await OpenAI.instance.responses.delete("response-id");
```

#### 💭 Conversations API
```dart
// Create conversation
OpenAIConversationModel conversation = await OpenAI.instance.conversations.create(
  // ... conversation parameters
);

// List conversations
List<OpenAIConversationModel> conversations = await OpenAI.instance.conversations.list();

// Retrieve conversation
OpenAIConversationModel conversation = await OpenAI.instance.conversations.retrieve("conversation-id");
```

#### 📊 Graders API
```dart
// Create grader
OpenAIGraderModel grader = await OpenAI.instance.graders.create(
  // ... grader parameters
);

// List graders
List<OpenAIGraderModel> graders = await OpenAI.instance.graders.list();
```

#### 📤 Uploads API
```dart
// Create upload
OpenAIUploadModel upload = await OpenAI.instance.uploads.create(
  // ... upload parameters
);

// List uploads
List<OpenAIUploadModel> uploads = await OpenAI.instance.uploads.list();
```

---

## 🛠️ Advanced Features

### Tools/Functions Calling
```dart
// Define a tool
final weatherTool = OpenAIToolModel(
  type: "function",
  function: OpenAIFunctionModel.withParameters(
    name: "get_weather",
    parameters: [
      OpenAIFunctionProperty.string(
        name: "location",
        description: "The city to get weather for",
      ),
    ],
  ),
);

// Use tool in chat
final chat = await OpenAI.instance.chat.create(
  model: "gpt-3.5-turbo",
  messages: [
    OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.user,
      content: "What's the weather like in New York?",
    ),
  ],
  tools: [weatherTool],
);
```

### Vision Support
```dart
final chat = await OpenAI.instance.chat.create(
  model: "gpt-4-vision-preview",
  messages: [
    OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.user,
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text("What's in this image?"),
        OpenAIChatCompletionChoiceMessageContentItemModel.imageUrl("https://example.com/image.jpg"),
      ],
    ),
  ],
);
```

### JSON Mode
```dart
final chat = await OpenAI.instance.chat.create(
  model: "gpt-3.5-turbo",
  messages: [
    OpenAIChatCompletionChoiceMessageModel(
      role: OpenAIChatMessageRole.user,
      content: "Return user data as JSON",
    ),
  ],
  responseFormat: {"type": "json_object"},
);
```

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

## 📈 Implementation Status

### Overall Progress: 65% Complete

- ✅ **Core APIs**: 100% Complete
- ✅ **Legacy APIs**: 100% Complete  
- ⚠️ **Newer APIs**: 20% Complete (stub implementations)
- ❌ **Latest APIs**: 0% Complete (missing)
- 🔧 **Custom APIs**: 100% Complete

### Priority Implementation Roadmap

1. **🔥 Critical**: Implement Assistants, Threads, Messages, Runs APIs
2. **🚨 High**: Complete Batch, Vector Stores, Evals implementations
3. **⚠️ Medium**: Add new Fine-tuning API, Tools management
4. **📝 Low**: Add Run Steps, Message Files, Fine-tuning Checkpoints

---

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### 🐛 Bug Reports
- Use GitHub Issues to report bugs
- Include reproduction steps and environment details

### 💡 Feature Requests
- Suggest new features via GitHub Issues
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