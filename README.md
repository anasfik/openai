# NEW: ChatGPT & Whisper APIs are [added](#chat-chatgpt) to the library and can be used directly.

<br>
<p align="center">
<img alt="GitHub commit activity" src="https://img.shields.io/github/commit-activity/m/anasfik/openai">
<img alt="GitHub contributors" src="https://img.shields.io/github/contributors/anasfik/openai">
<img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/anasfik/openai?style=social">
<img alt="GitHub Workflow Status" src="https://img.shields.io/github/actions/workflow/status/anasfik/openai/dart.yml?label=tests">
<img alt="GitHub Workflow Status" src="https://img.shields.io/github/actions/workflow/status/anasfik/openai/release.yml?label=build">
<img alt="GitHub" src="https://img.shields.io/github/license/anasfik/openai">
<img alt="Pub Version" src="https://img.shields.io/pub/v/dart_openai">
<img alt="Pub Likes" src="https://img.shields.io/pub/likes/dart_openai">
<img alt="Pub Points" src="https://img.shields.io/pub/points/dart_openai">
<img alt="Pub Popularity" src="https://img.shields.io/pub/popularity/dart_openai">

</p>

</br>

<h3>Help this grow and get discovered by other devs with a ⭐ star.</h3>

</br>
</br>

An open-source Client package that allows developers to easily integrate the power of OpenAI's state-of-the-art AI models into their Dart/Flutter applications.

This library provides simple and intuitive methods for making requests to OpenAI's various APIs, including the GPT-3 language model, DALL-E image generation, and more.

The package is designed to be lightweight and easy to use, so you can focus on building your application, rather than worrying about the complexities and errors caused by dealing with HTTP requests.

</br>
</br>

<i>Unofficial</i>
</br>
<i>OpenAI does not have any official Dart library.</I>

### Note:

Please note that this client SDK connects directly to [OpenAI APIs](https://platform.openai.com/docs/introduction/overview) using HTTP requests.

## ✨ Key Features

- Easy to use methods that reflect exactly the OpenAI documentation, with additional functionalities that make it better to use with Dart Programming Language.
- Authorize just once, use it anywhere and at any time in your application.
- Developer-friendly.
- `Stream` functionality for completions API & fine-tune events API.

## 👑 Code Progress (100 %)

- [x] [Authentication](#authentication)
- [x] [Models](#models)
- [x] [Completions](#completions)
  - [x] With `Stream` responses.
- [x] [Chat (chatGPT)](#chat-chatgpt)
  - [x] With `Stream` responses.
- [x] [Edits](#edits)
- [x] [Images](#images)
- [x] [Embeddings](#embeddings)
- [x] [Audio](#audio)
- [x] [Files](#files)
- [x] [Fine-tunes](#fine-tunes)
  - [x] With events `Stream` responses.
- [x] [Moderation](#moderations)

## 💫 Testing Progress (100 %)

- [x] [Authentication](#authentication)
- [x] [Models](#models)
- [x] [Completions](#completions)
- [x] [chat (chatGPT)](#chat-chatgpt)
- [x] [Edits](#edits)
- [x] [Images](#images)
- [x] [Embeddings](#embeddings)
- [x] [Audio](#audio)
- [x] [Files](#files)
- [x] [Fine-tunes](#fine-tunes)
- [x] [Moderation](#moderations)</br>

</br>

# 📜 Full Documentation:

For the full documentation about all members this library offers, [check here](https://pub.dev/documentation/dart_openai/latest/).

</br>

# 🟢 Usage

## Authentication

### API key

The OpenAI API uses API keys for authentication. you can get your account APU key by visiting [API keys](https://platform.openai.com/account/api-keys) of your account.

We highly recommend loading your secret key at runtime from a `.env` file, you can use the [envied](https://pub.dev/packages/envied) package.

```
// .env
OPEN_AI_API_KEY=<REPLACE WITH YOUR API KEY>
```

```dart
// lib/env/env.dart
import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: ".env")
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_API_KEY') // the .env variable.
  static const apiKey = _Env.apiKey;
}
```

```dart
// lib/main.dart
void main() {
 OpenAI.apiKey = Env.apiKey; // Initializes the package with that API key
 // ..
}
```

if no `apiKey` is set, and you tried to access `OpenAI.instance`, a `MissingApiKeyException` will be thrown even before making the actual request.

if the `apiKey` is set, but it is invalid when making requests, a `RequestFailedException` will be thrown in your app, check the [error handling](#error-handling) section for more info.

### Setting an organization

if you belong to a specific organization, you can pass its id to `OpenAI.organization` like this:

```dart
 OpenAI.organization = "ORGANIZATION ID";
```

If you don't belong actually to any organization, you can just ignore this section, or set it to `null`.

[Learn More From Here.](https://platform.openai.com/docs/api-reference/authentication)

</br>

## Models

### List Models

Lists the currently available models, and provides basic information about each one such as the owner and availability.

```dart
 List<OpenAIModelModel> models = await OpenAI.instance.model.list();
 OpenAIModelModel firstModel = models.first;

 print(firstModel.id); // ...
```

### Retrieve model.

Retrieves a single model by its id and gets additional pieces of information about it.

```dart
 OpenAIModelModel model = await OpenAI.instance.model.retrieve("text-davinci-003");
 print(model.id);
```

If the model id does not exist, a `RequestFailedException` will be thrown, check [Error Handling](#error-handling) section.

[Learn More From Here.](https://platform.openai.com/docs/api-reference/models)

</br>

## Completions

### Create completion

Creates a Completion based on the provided properties `model`, `prompt` & other properties.

```dart
OpenAICompletionModel completion = await OpenAI.instance.completion.create(
  model: "text-davinci-003",
  prompt: "Dart is a progr",
  maxTokens: 20,
  temperature: 0.5,
  n: 1,
  stop: ["\n"],
  echo: true,
);
```

if the request failed (as an example, if you did pass an invalid model id...), a `RequestFailedException` will be thrown, check [Error Handling](#error-handling) section.

### Create Completion Stream

In addition to calling the `OpenAI.instance.completion.create()` which is a `Future` and will not return an actual value until the completion is ended, you can get a `Stream` of values as they are generated:

```dart
Stream<OpenAIStreamCompletionModel> completionStream = OpenAI.instance.completion.createStream(
  model: "text-davinci-003",
  prompt: "Github is ",
  maxTokens: 100,
  temperature: 0.5,
  topP: 1,
 );

completionStream.listen((event) {
 final firstCompletionChoice = event.choices.first;
 print(firstCompletionChoice.text); // ...
});
```

[Learn More From Here.](https://platform.openai.com/docs/api-reference/completions)

</br>

## Chat (ChatGPT)

### Create chat completion

Creates a completion for the chat message, note you need to set each message as a `OpenAIChatCompletionChoiceMessageModel` object.

```dart
OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
    model: "gpt-3.5-turbo",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        content: "hello, what is Flutter and Dart ?",
        role: OpenAIChatMessageRole.user,
        ),
    ],
);
```

### Create a chat completion stream

in addition to calling `OpenAI.instance.chat.create()` which is a `Future` and will resolve only after the whole chat is generated, you can get a `Stream` of results:

```dart
OpenAIStreamChatCompletionModel chatStream = OpenAI.instance.chat.createStream(
    model: "gpt-3.5-turbo",
    messages: [
      OpenAIChatCompletionChoiceMessageModel(
        content: "hello",
        role: OpenAIChatMessageRole.user,
      )
    ],
  );

chatStream.listen((chatStreamEvent) {
print(chatStreamEvent); // ...
  });
```

</br>

## Edits

### Create edit

Creates an edited version of the given prompt based on the used model.

```dart
OpenAIEditModel edit = await OpenAI.instance.edit.create(
model: "text-davinci-edit-001";
instruction: "remote all '!'from input text",
input: "Hello!!, I! need to be ! somethi!ng"
n: 1,
temperature: 0.8,
);
```

[Learn More From Here.](https://platform.openai.com/docs/api-reference/edits)

</br>

## Images

### Create image

Generates a new image based on a prompt given.

```dart
 OpenAIImageModel image = await OpenAI.instance.image.create(
  prompt: 'an astronaut on the sea',
  n: 1,
  size: OpenAIImageSize.size1024,
  responseFormat: OpenAIImageResponseFormat.url,
);
```

### Create image edit

Creates an edited or extended image given an original image and a prompt.

```dart
OpenAiImageEditModel imageEdit = await OpenAI.instance.image.edit(
 file: File(/* IMAGE PATH HERE */),
 mask: File(/* MASK PATH HERE */),
 prompt: "mask the image with a dinosaur",
 n: 1,
 size: OpenAIImageSize.size1024,
 responseFormat: OpenAIImageResponseFormat.url,
);
```

### Create image variation

Creates a variation of a given image.

```dart
OpenAIImageVariationModel imageVariation = await OpenAI.instance.image.variation(
 image: File(/* IMAGE PATH HERE */),
 n: 1,
 size: OpenAIImageSize.size1024,
 responseFormat: OpenAIImageResponseFormat.url,
);
```

[Learn More From Here.](https://platform.openai.com/docs/api-reference/images)

</br>

## Embeddings

Get a vector representation of a given input that can be easily consumed by machine learning models and algorithms.

### Create embeddings

```dart
OpenAIEmbeddingsModel embeddings = await OpenAI.instance.embedding.create(
 model: "text-embedding-ada-002",
 input: "This is a text input just to test",
);
```

[Learn More From Here.](https://platform.openai.com/docs/api-reference/embeddings)

</br>

# Audio

## Create transcription

for transcribing an audio `File`, you can use the `createTranscription()` method directly by providing the `file` property:

```dart
OpenAIAudioModel transcription = OpenAI.instance.audio.createTranscription(
  file: /* THE AUDIO FILE HERE */,
  model: "whisper-1",
  responseFormat: OpenAIAudioResponseFormat.json,
);
```

## Create translation

to get access to the translation API, and translate an audio file to english, you can use the `createTranslation()` method, by providing the `file`` property:

```dart
OpenAIAudioModel translation = await OpenAI.instance.audio.createTranslation(
  file: /* THE AUDIO FILE HERE */,
  model: "whisper-1",
  responseFormat: OpenAIAudioResponseFormat.text,

);
```

</br>

## Files

Files are used to upload documents that can be used with features like [Fine-tuning](#fine-tunes).

### List files

Get a list of all the uploaded files o-to your OpenAI account.

```dart
List<OpenAIFileModel> files = await OpenAI.instance.file.list();

print(files.first.fileName); // ...
print(files.first.id); // ...
```

### Upload file

Upload a file that contains document(s) to be used across various endpoints/features. Currently, the size of all the files uploaded by one organization can be up to 1 GB. Please contact us if you need to increase the storage limit.

```dart
OpenAIFileModel uploadedFile = await OpenAI.instance.file.upload(
 file: File("/* FILE PATH HERE */"),
 purpose: "fine-tuning",
);

print(uploadedFile.id); // ...
```

### Delete file

Deletes an existent file by it's id.

```dart
bool isFileDeleted = await OpenAI.instance.file.delete("/* FILE ID */");

print(isFileDeleted);
```

### Retrieve file

Fetches for a single file by it's id and returns informations about it.

```dart
OpenAIFileModel file = await OpenAI.instance.file.retrieve("FILE ID");
print(file.id);
```

### Retrieve file content

Fetches for a single file content by it's id.

```dart
dynamic fileContent  = await OpenAI.instance.file.retrieveContent("FILE ID");

print(fileContent);
```

[Learn More From Here.](https://platform.openai.com/docs/api-reference/files)

</br>

## Fine Tunes

### Create fine-tune

Creates a job that fine-tunes a specified model from a given dataset, and returns a fine-tuned object about the enqueued job.

```dart
OpenAIFineTuneModel fineTune = await OpenAI.instance.fineTune.create(
 trainingFile: "FILE ID",
);

print(fineTune.status); // ...
```

### List fine-tunes

List your organization's fine-tuning jobs.

```dart
List<OpenAIFineTuneModel> fineTunes = await OpenAI.instance.fineTune.list();

print(fineTunes.first); // ...
```

### Retrieve fine-tune

Retrieves a fine-tune by its id.

```dart
OpenAIFineTuneModel fineTune = await OpenAI.instance.fineTune.retrieve("FINE TUNE ID");

print(fineTune.id); // ...
```

### Cancel fine-tune

Cancels a fine-tune job by its id, and returns it.

```dart
OpenAIFineTuneModel cancelledFineTune = await OpenAI.instance.fineTune.cancel("FINE TUNE ID");

print(cancelledFineTune.status); // ...
```

### List fine-tune events

Lists a single fine-tune progress events by it's id.

```dart
 List<OpenAIFineTuneEventModel> events = await OpenAI.instance.fineTune.listEvents("FINE TUNE ID");

 print(events.first.message); // ...
```

### Listen to fine-tune events `Stream`

Streams all events of a fine-tune job by its id, as they happen.

This is a long-running operation that will not return until the fine-tune job is terminated.

The stream will emit an event every time a new event is available.

```dart
Stream<OpenAIFineTuneEventStreamModel> eventsStream = OpenAI.instance.fineTune.listEventsStream("FINE TUNE ID");

eventsStream.listen((event) {
 print(event.message);
});
```

### Delete fine-tune

Deletes a fine-tune job by its id.

```dart
 bool deleted = await OpenAI.instance.fineTune.delete("FINE TUNE ID");

print(deleted); // ...
```

[Learn More From Here.](https://platform.openai.com/docs/api-reference/fine-tunes)

</br>
 
## Moderations

### Create moderation

Classifies if text violates OpenAI's Content Policy

```dart
OpenAIModerationModel moderation = await OpenAI.instance.moderation.create(
  input: "I want to kill him",
);

print(moderation.results); // ...
print(moderation.results.first.categories.hate); // ...
```

[Learn More From Here.](https://platform.openai.com/docs/api-reference/moderations)

<br>

## Error Handling

Any time an error happens from the OpenAI API ends (As Example: when you try to create an image variation from a non-image file.. , a `RequestFailedException` will be thrown automatically inside your Flutter / Dart app, you can use a `try-catch` to catch that error, and make an action based on it:

```dart
try {

// This will throw an error.
 final errorVariation = await OpenAI.instance.image.variation(
  image: File(/*PATH OF NON-IMAGE FILE*/),
 );
} on RequestFailedException catch(e) {
 print(e.message);
 print(e.statusCode);
}
```

<br>
<br>

#### Want To Help ?

Please, Just remember that any kind of help related to these tasks are welcome, for the sake of the community.

- Writing documentation: if you see any class, property, method.. that you know what does and it is undocumented, please take from your time 2 minutes and help another developer that doesn't.
- Code Refactoring: I know this is my job not yours :), but if you can and want, you're more than welcome.
- Reviewing code: if it happens that there is a better way to make something happen in the SDK, please just let me know.
- if you tried any sample of use cases, examples of yours and wanted to include it in the examples/, please go ahead.
