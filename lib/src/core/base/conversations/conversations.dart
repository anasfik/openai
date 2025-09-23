import 'package:dart_openai/src/core/base/conversations/interfaces/create.dart';
import 'package:dart_openai/src/core/base/conversations/interfaces/delete.dart';
import 'package:dart_openai/src/core/base/conversations/interfaces/get.dart';
import 'package:dart_openai/src/core/base/conversations/interfaces/update.dart';
import 'package:dart_openai/src/core/base/entity/interfaces/enpoint.dart';

abstract class OpenAIConversationsBase
    implements
        CreateInterface,
        GetInterface,
        UpdateInterface,
        DeleteInterface,
        EndpointInterface {}
