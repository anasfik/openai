import 'package:openai/src/core/builder/base_api_url.dart';
import 'package:openai/src/core/models/image.dart';
import 'package:openai/src/core/networking/client.dart';

import '../../core/base/images/base.dart';

class OpenAIImages implements OpenAIImagesBase {
  @override
  String get endpoint => "/images/generations";

  @override
  Future<OpenAIImageModel> create({
    required String prompt,
    int? n,
    String? size,
    String? responseFormat,
    String? user,
  }) async {
    return await OpenAINetworkingClient.post(
      to: BaseApiUrlBuilder.build(endpoint),
      onSuccess: (json) => OpenAIImageModel.fromJson(json),
      body: {
        "prompt": prompt,
        if (n != null) "n": n,
        if (size != null) "size": size,
        if (responseFormat != null) "response_format": responseFormat,
        if (user != null) "user": user,
      },
    );
  }
}
