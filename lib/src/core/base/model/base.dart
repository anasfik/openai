import '../entity/base.dart';
import 'interfaces/list.dart';
import 'interfaces/one.dart';

abstract class OpenAIModelBase
    implements OpenAIEntityBase, ListInterface, RetrieveInterface {}
