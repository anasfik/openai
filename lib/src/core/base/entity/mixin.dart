import '../../builder/base_api_url.dart';
import 'base.dart';

mixin OpenAIEntityBaseFullApiUriMixin on OpenAIEntityBase {
  String get fullApiUri => BaseApiUrlBuilder.build(endpoint);
}
