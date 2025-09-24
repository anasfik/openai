import 'package:dart_openai/src/core/base/conversations/interfaces/update.dart';
import 'package:dart_openai/src/core/base/evals/interfaces/cancel.dart';
import 'package:dart_openai/src/core/base/evals/interfaces/create.dart';
import 'package:dart_openai/src/core/base/evals/interfaces/delete.dart';
import 'package:dart_openai/src/core/base/evals/interfaces/get.dart';

abstract class OpenAIEvalsBase
    implements
        CreateInterface,
        GetInterface,
        UpdateInterface,
        DeleteInterface,
        CancelInterface {}
