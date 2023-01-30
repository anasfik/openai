# Dart SDK for openAI Apis (GPT-3 & DALL-E)

An open-source package that allows developers to easily integrate the power of OpenAI's state-of-the-art AI models into their Dart applications. This library provides a simple and intuitive methods for making requests to OpenAI's various APIs, including the GPT-3 language model, DALL-E image generation, and more.


The package is designed to be lightweight and easy to use, so you can focus on building your application, rather than worrying about the complexities of the underlying API.
<br>
<br>

<i>Unofficial</i><br>
<i>openAI don't have any official Dart library.</I>

## Progress
- [ ] ChatGPT ( as soon as possible when it's released )
- [x] Authentication
- [x] Models
- [x] Completions
- [x] Edits
- [x] Images
- [ ] Embeddings
- [ ] Files
- [ ] Fine-tunes
- [ ] Moderation
- [ ] Rate limit support

<br>

# Authentication
## API key
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

<br>

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


<br>

# Completions
## Create completion

```dart
 OpenAICompletionModel completion = await OpenAI.instance.completion.create(
   model: "text-davinci-003",
   prompt: "Dart is a ",
   temperature: 0.8,
 );
```
<br>

# Edits
## Create edit

```dart
 OpenAIEditModel a = await OpenAI.instance.edit.create(
   model: "text-davinci-edit-001",
   input: " Hi!, I am a bot!!!!,",
   instruction: "remove all ! the input ",
 );
```

# Images
## Create image
```dart
 OpenAIImageModel image = await OpenAI.instance.image.create(
   prompt: "A dog",
   n: 1,
 );
```
