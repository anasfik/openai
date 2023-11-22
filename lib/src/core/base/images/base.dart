import 'package:dart_openai/src/core/base/entity/interfaces/enpoint.dart';

import '../../enum.dart';
import 'interfaces/create.dart';
import 'interfaces/edit.dart';
import 'interfaces/variations.dart';

abstract class OpenAIImagesBase
    implements
        EndpointInterface,
        CreateInterface,
        EditInterface,
        VariationInterface {}

extension SizeToStingExtension on OpenAIImageSize {
  String get value {
    switch (this) {
      case OpenAIImageSize.size256:
        return "256x256";
      case OpenAIImageSize.size512:
        return "512x512";
      case OpenAIImageSize.size1024:
        return "1024x1024";
      case OpenAIImageSize.size1792Horizontal:
        return "1792x1024";
      case OpenAIImageSize.size1792Vertical:
        return "1024x1792";
    }
  }
}

extension StyleToStingExtension on OpenAIImageStyle {
  String get value {
    return name;

    // ! pretty sure this will be needed in the future in case of adding more styles that can't be got from the `name` field.
    // switch (this) {
    //   case OpenAIImageStyle.vivid:
    //     return "vivid";
    //   case OpenAIImageStyle.natural:
    //     return "natural";
    // }
  }
}

extension QualityToStingExtension on OpenAIImageQuality {
  String get value {
    return name;

    // ! pretty sure this will be needed in the future in case of adding more qualities that can't be got from the `name` field.
    // switch (this) {
    //   case OpenAIImageQuality.hd:
    //     return "hd";
    // }
  }
}

extension ResponseFormatToStingExtension on OpenAIImageResponseFormat {
  String get value {
    switch (this) {
      case OpenAIImageResponseFormat.url:
        return "url";
      case OpenAIImageResponseFormat.b64Json:
        return "b64_json";
    }
  }
}
