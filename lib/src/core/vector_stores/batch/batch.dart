import 'package:dart_openai/src/core/vector_stores/batch/interfaces/cancel.dart';
import 'package:dart_openai/src/core/vector_stores/batch/interfaces/create.dart';
import 'package:dart_openai/src/core/vector_stores/batch/interfaces/get.dart';

abstract class OpenAIVectorStoreBatchBase
    implements CreateInterface, GetInterface, CancelInterface {}
