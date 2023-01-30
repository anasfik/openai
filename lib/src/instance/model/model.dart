import 'package:openai/src/core/builder/base_api_url.dart';

import '../../core/base/entity/base.dart';



class OpenAIModel implements OpenAIEntityBase {
  @override
  String get endpoint => "/models";
}
