import 'dart:io';

import 'package:dart_openai/src/core/builder/base_api_url.dart';
import 'package:dart_openai/src/core/models/image/image/image.dart';
import 'package:dart_openai/src/core/networking/client.dart';
import 'package:meta/meta.dart';

import '../../core/base/images/base.dart';
import '../../core/constants/strings.dart';
import '../../core/models/image/edit/image_edit.dart';

import '../../core/models/image/enum.dart';
import '../../core/models/image/variation/variation.dart';
import '../../core/utils/logger.dart';

import 'package:http/http.dart' as http;

/// {@template openai_images}
/// The class that handles all the requests related to the images in the OpenAI API.
/// {@endtemplate}
@immutable
@protected
interface class OpenAIImages implements OpenAIImagesBase {
  @override
  String get endpoint => OpenAIStrings.endpoints.images;

  /// {@macro openai_images}
  OpenAIImages() {
    OpenAILogger.logEndpoint(endpoint);
  }

  /// This function creates an image based on a given prompt.
  ///
  ///
  /// [prompt] is a text description of the desired image(s). The maximum length is 1000 characters.
  ///
  ///
  /// [n] is the number of images to generate. Must be between 1 and 10.
  ///
  ///
  /// [size] is the size of the generated images. Must be one of :
  /// - `OpenAIImageSize.size256`
  /// - `OpenAIImageSize.size512`
  /// - `OpenAIImageSize.size1024`
  ///
  ///
  /// [responseFormat] is the format in which the generated images are returned. Must be one of :
  /// - `OpenAIImageResponseFormat.url`
  /// - `OpenAIImageResponseFormat.b64Json`
  ///
  ///
  /// [user] is the user ID to associate with the request. This is used to prevent abuse of the API.
  ///
  ///
  /// Example:
  ///```dart
  /// OpenAIImageModel image = await OpenAI.instance.image.create(
  ///  prompt: 'create an image about the sea',
  ///  n: 1,
  ///  size: OpenAIImageSize.size1024,
  ///  responseFormat: OpenAIImageResponseFormat.url,
  /// );
  ///```
  @override
  Future<OpenAIImageModel> create({
    required String prompt,
    int? n,
    OpenAIImageSize? size,
    OpenAIImageResponseFormat? responseFormat,
    String? user,
    http.Client? client,
  }) async {
    final String generations = "/generations";

    return await OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.build(endpoint + generations),
      onSuccess: (json) => OpenAIImageModel.fromMap(json),
      body: {
        "prompt": prompt,
        if (n != null) "n": n,
        if (size != null) "size": size.value,
        if (responseFormat != null) "response_format": responseFormat.value,
        if (user != null) "user": user,
      },
      client: client,
    );
  }

  /// Creates an edited or extended image given an original image and a prompt.
  ///
  /// [image] to edit. Must be a valid PNG file, less than 4MB, and square. If mask is not provided, image must have transparency, which will be used as the mask.
  ///
  ///
  /// [mask] defines an additional image whose fully transparent areas (e.g. where alpha is zero) indicate where image should be edited. Must be a valid PNG file, less than 4MB, and have the same dimensions as image.
  ///
  ///
  /// [prompt] A text description of the desired image(s). The maximum length is 1000 characters.
  ///
  /// [n] is the number of images to generate. Must be between 1 and 10.
  ///
  ///
  /// [size] is the size of the generated images. Must be one of :
  /// - `OpenAIImageSize.size256`
  /// - `OpenAIImageSize.size512`
  /// - `OpenAIImageSize.size1024`
  ///
  ///
  /// [responseFormat] is the format in which the generated images are returned. Must be one of :
  /// - `OpenAIImageResponseFormat.url`
  /// - `OpenAIImageResponseFormat.b64Json`
  ///
  ///
  ///
  /// [user] is the user ID to associate with the request. This is used to prevent abuse of the API.
  ///
  ///
  /// Example:
  ///```dart
  /// OpenAiImageEditModel imageEdit = await OpenAI.instance.image.edit(
  ///  file: File(/* IMAGE PATH HERE */),
  ///  mask: File(/* MASK PATH HERE */),
  ///  prompt: "mask the image with a dinosaur in the image",
  ///  n: 1,
  ///  size: OpenAIImageSize.size1024,
  ///  responseFormat: OpenAIImageResponseFormat.url,
  /// );
  ///```
  @override
  Future<OpenAiImageEditModel> edit({
    required File image,
    File? mask,
    required String prompt,
    int? n,
    OpenAIImageSize? size,
    OpenAIImageResponseFormat? responseFormat,
    String? user,
  }) async {
    final String edit = "/edits";
    return await OpenAINetworkingClient.imageEditForm<OpenAiImageEditModel>(
      image: image,
      mask: mask,
      body: {
        "prompt": prompt,
        if (n != null) "n": n.toString(),
        if (size != null) "size": size.value,
        if (responseFormat != null) "response_format": responseFormat.value,
        if (user != null) "user": user,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAiImageEditModel.fromMap(response);
      },
      to: BaseApiUrlBuilder.build(endpoint + edit),
    );
  }

  /// Creates a variation of a given image.
  ///
  ///
  /// [image] to use as the basis for the variation(s). Must be a valid PNG file, less than 4MB, and square.
  ///
  ///
  /// [n] is the number of images to generate. Must be between 1 and 10.
  ///
  ///
  /// [size] is the size of the generated images. Must be one of :
  /// - `OpenAIImageSize.size256`
  /// - `OpenAIImageSize.size512`
  /// - `OpenAIImageSize.size1024`
  ///
  ///
  /// [responseFormat] is the format in which the generated images are returned. Must be one of :
  /// - `OpenAIImageResponseFormat.url`
  /// - `OpenAIImageResponseFormat.b64Json`
  ///
  ///
  /// [user] is the user ID to associate with the request. This is used to prevent abuse of the API.
  ///
  ///
  /// Example:
  /// ```dart
  /// OpenAIImageVariationModel imageVariation = await OpenAI.instance.image.variation(
  /// image: File(/* IMAGE PATH HERE */),
  /// n: 1,
  /// size: OpenAIImageSize.size1024,
  /// responseFormat: OpenAIImageResponseFormat.url,
  /// );
  /// ```
  @override
  Future<OpenAIImageVariationModel> variation({
    required File image,
    int? n,
    OpenAIImageSize? size,
    OpenAIImageResponseFormat? responseFormat,
    String? user,
  }) async {
    final String variations = "/variations";

    return await OpenAINetworkingClient.imageVariationForm<
        OpenAIImageVariationModel>(
      image: image,
      body: {
        if (n != null) "n": n.toString(),
        if (size != null) "size": size.value,
        if (responseFormat != null) "response_format": responseFormat.value,
        if (user != null) "user": user,
      },
      onSuccess: (Map<String, dynamic> response) {
        return OpenAIImageVariationModel.fromMap(response);
      },
      to: BaseApiUrlBuilder.build(endpoint + variations),
    );
  }
}
