# Dart SDK for openAI Apis (GPT-3 & DALL-E)

An open-source SDK that allows developers to easily integrate the power of OpenAI's state-of-the-art AI models into their Dart applications. This library provides simple and intuitive methods for making requests to OpenAI's various APIs, including the GPT-3 language model, DALL-E image generation, and more.

The package is designed to be lightweight and easy to use, so you can focus on building your application, rather than worrying about the complexities and error caused by dealing with http requests.
</br>
</br>

<i>Unofficial</i>
</br>
<i>OpenAI does not have any official Dart library.</I>

#### Note:

Please note that this client SDK connects directly to openAI APIs using http requests, it doesn't provide any additional APIs than what exists [here](https://platform.openai.com/docs/introduction/overview).

## Progress

- [ ] ChatGPT ( as soon as possible when it's released )
- [x] [Authentication](#authentication)
- [x] [Models](#models)
- [x] [Completions](#completions)
  - [x] With `Stream` responses
- [x] [Edits](#edits)
- [x] [Images](#images)
- [x] [Embeddings](#embeddings)
- [x] [Files](#files)
- [x] [Fine-tunes](#fine-tunes)
  - [ ] With events `Stream` responses
- [x] [Moderation](#moderations)

## Testing Progress

- [x] [Authentication](#authentication)
- [x] [Models](#models)
- [x] [Completions](#completions)
- [x] [Edits](#edits)
- [x] [Images](#images)
- [x] [Embeddings](#embeddings)
- [x] [Files](#files)
- [ ] [Fine-tunes](#fine-tunes)
- [x] [Moderation](#moderations)</br>

# Authentication

## API key

We highly recommend loading your secret key at runtime using an `.env` file, you can use the [dotenv](https://pub.dev/packages/flutter_dotenv) package.

```dart
void main() {
 OpenAI.apiKey = dotenv.env["OPEN_AI_KEY"]!;
 // ..
}
```

## Requesting organization

```dart
 OpenAI.organization = "ORGANIZATION ID";
```

</br>

# Models

## List Models

Lists the currently available models, and provides basic information about each one such as the owner and availability.

```dart
 final models = await OpenAI.instance.model.list();
 print(models.first.id);
```

## Retrieve model

Retrieves a model instance, providing basic information about the model such as the owner and permissioning.

```dart
 final model = await OpenAI.instance.model.one("MODEL ID");
 print(model.id)
```

</br>

# Completions

## Create completion

```dart
 OpenAICompletionModel completion = await OpenAI.instance.completion.create(
   model: "text-davinci-003",
   prompt: "Dart is a ",
   temperature: 0.8,
 );
```

</br>

# Edits

## Create edit

```dart
 OpenAIEditModel edit = await OpenAI.instance.edit.create(
   model: "text-davinci-edit-001",
   input: " Hi!, I am a bot!!!!,",
   instruction: "remove all ! the input ",
 );
```

</br>

# Images

## Create image

```dart
 OpenAIImageModel image = await OpenAI.instance.image.create(
   prompt: "A dog",
   n: 1,
 );
```

## Create image edit

```dart
 final result = await OpenAI.instance.image.edit(
   image: File(/* image file path*/),
   mask: File(/* mask file path*/),
   prompt: "change color to green",
   n: 1,
 );

```

## Create image variation

```dart
OpenAIImageVariationModel variation = await OpenAI.instance.image.variation(
 image: File(/*YOUR IMAGE FILE PATH*/),
);
```

</br>

# Embeddings

## Create embeddings

```dart
OpenAIEmbeddingsModel embeddings = await OpenAI.instance.embedding.create(
  model: "text-embedding-ada-002",
  input: "This is a text input just to test",
);;
```

</br>

# Files

## List files

```dart
List<OpenAIFileModel> files = await OpenAI.instance.file.list();
```

## Upload file

```dart
OpenAIFileModel uploadedFile = await OpenAI.instance.file.upload(
 file: File("FILE PATH HERE"),
 purpose: "fine-tuning",
);
```

## Delete file

```dart
bool isFileDeleted = await OpenAI.instance.file.delete("FILE ID");
```

## Retrieve file

```dart
OpenAIFileModel file = await OpenAI.instance.file.retrieve("FILE ID");
```

## Retrieve file content

```dart
dynamic fileContent  = await OpenAI.instance.file.retrieveContent("FILE ID");
```

</br>

# Fine Tunes

## Create fine-tune

```dart
OpenAIFineTuneModel fineTune = await OpenAI.instance.fineTune.create(
 trainingFile: "FILE ID",
);
```

## List fine-tunes

```dart
List<OpenAIFineTuneModel> fineTunes = await OpenAI.instance.fineTune.list();
```

## Retrieve fine-tune

```dart
OpenAIFineTuneModel fineTune = await OpenAI.instance.fineTune.retrieve("FINE TUNE ID");
```

## Cancel fine-tune

```dart
OpenAIFineTuneModel fineTune = await OpenAI.instance.fineTune.cancel("FINE TUNE ID");
```

## List fine-tune events

```dart
 List<OpenAIFineTuneEventModel> events = await OpenAI.instance.fineTune.listEvents("FINE TUNE ID");
```

## Delete fine-tune

```dart
 bool deleted = await OpenAI.instance.fineTune.delete("FINE TUNE ID");
```

</br>
 
# Moderations
## Create moderation
```dart
OpenAIModerationModel moderationResult = await OpenAI.instance.moderation.create(
  input: "I want to kill him",
);
```
