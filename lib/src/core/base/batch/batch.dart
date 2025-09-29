import 'package:dart_openai/src/core/base/batch/cancel.dart';
import 'package:dart_openai/src/core/base/batch/get.dart';
import 'package:dart_openai/src/core/base/batch/interfaces/create.dart';

abstract class OpenAIBatchBase
    implements CreateInterface, GetInterface, CancelInterface {}
