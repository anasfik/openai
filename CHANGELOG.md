# Changelog

## NEXT

- Support for logprobs in the chat completions API.

- Bug fixes.

## 5.1.0

- Massive issues fixes related to incorrecr use of types, model fields..., audio transcription file streaming error handling, and more.

- Support for newer fields & options for the chat completions API, like `name` for messages.

- Support for audio transcription granularity.

- General improvements, and more tests.

## 5.0.0

- Bug fix in the `RequestFunctionMessage`'s `toMap()` method.
- Minor changes
- Add/Improvements to the documentation.
- Notifications about breaking changes in the chat completions methods in favor of OpenAI Vision feature support, JSON mode..

## 4.1.4

- Removed the exposed field for configuring the package to use fetch_client instead of http_client manually withe is `isWeb` field, in favor of using `dart.library.js` and `dart.library.io` conditional imports to automatically detect the platform and use the appropriate client for it.
- Exposed field for configuring the package to use fetch_client instead of http_client for making requests in web apps (flutter web, etc..)

## 4.1.3

- Added Audio Speech method in the Audio module with its docs, example code.
- Migrated for the deprecated \_`functions`\_and `function_call` th the use of new fields such `tools`.. in the chat API, confirmed that it works on both asynchronous and stream responses.
- Exposed API for controlling the requests time out for all internal client methods.
- Exposed multi content calls for chat completion API for image and text..

## 4.1.2

- Disabled a print method that was used for debugging purposes.

## 4.1.1

- Fixed the non applied `n` field in image variation method.
- Exposed non-breaking `model` field for other image APIs methods.

## 4.1.0

- Bugs & issues fixes.
- Followed up with more changes in the OpenAI API.
- Added more documentation for the package.
- Added more examples for the package.
- Added more tests for the package.

## 4.0.0

- Migrated internal packages to latest versions such as http.
- Bug fixes to new functions API
- Minor edits to docs, package members.

## 3.0.0

- Added support for functions feature of the chat API.
- Bugs fixes.

## 2.0.1

- Formated unformatted files.

## 2.0.0

- Exposing of custom thttp client for methods- Fixed issue related to streams that uses a custom http client.

## 1.9.93

- Added custom HTTP client options for all the package APIs that requires one.

## 1.9.92

- exposed an external method for inclusing custom headers to the requests.

## 1.9.91

- Fixed minor issue.

## 1.9.9

- More refatocration for the packages services.
- Fixes some minor issues with the logging service.
- Removed repeated constants, code.

## 1.9.8

- Fixed the non catched error for stream functionality of chat completions and completions.
- Added example for testing the catchong of errors in the stream like when the internet connectioni off.

## 1.9.7

- Added more examples for the package use in /example folder.

## 1.9.6

- Added more helper memebers for some models.
- Minor changes to some implementations.

## 1.9.5

- More issues fixes.

## 1.9.0

- Exposed more enums to be used with the library.
- Added more documentation for more low level é models SDK's APIs
- Applied fixes relating to web streams APIs.

## 1.8.4

- base url not changeable after first request fixed.

## 1.8.3

- Fixed web issue for chat streams
- Exposed the base url to be changed externally

## 1.8.0

- Added the Audio APIs including creating transcription and translation.
- More documentation for models properties.

## 1.6.1

- Added documentation of chat completion stream.

## 1.6.0

- Added And Fixed chat completions stream.
- Fixed the error concerning the openAI usual errors while using streams for chat completions and completion.

## 1.5.5

- Added new ChatGPT API to the library.

## 1.4.9

- Ensured immutability of results from requests.
- Exposed more equality for sdk models

## 1.4.8

- Fix issues
- Fix doubled stream snapshots than expected.

## 1.4.6

- Changed the use of dotenv to envied package.

## 1.4.4

- Fixed echo property type misleading.

## 1.4.2

- UTF-8 Support fix for responses.

## 1.4.0

- Added implementation of fine-tune events Stream.
- Added more documentation.
- Fixed issues.

## 1.3.0

- Fixed the Stream based mechanism for completion stream.

## 1.2.3

- Exposed image size and url enums to be used externally

## 1.2.1

- formatted some dart files

## 1.2.0

- Added more detailed documentation that reflects OpenAI's.
- Added more helper methods, enums for making it more easy to manipulate properties and decrease error chances
- More Examples, explanations for README.md.
- Code Improvments.

## 1.1.2

- Added more detailed documentation that reflects OpenAI's.
- Added more helper methods, enums for making it more easy to manipulate properties and decrease error chances
- More Examples, explanations for README.md.
- Code Improvments.

## 1.1.0

- Set internal packages version to any

## 1.0.9

- Downgraded internal meta package version to 1.8.0

## 1.0.8

- Made improvements
- Added example to showcase how to use.

## 1.0.7

- Informed about using the dotenv package instead of flutter_dotenv since not all dart applications are flutter's.
- Fixed issues

## 1.0.6

- added tests for fine-tunes
- fixed type system issues
-

## 1.0.5

- Added error handling explanation, example in the README.md

## 1.0.4

- Added clarifications in READMe.md

## 1.0.3

- Fixed issues

## 1.0.1

- fixed issues
- Added documentation for responses fields for better understanding, familiarization for developer.

## 1.0.0

- All APIs are included.
