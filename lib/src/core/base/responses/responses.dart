import 'package:dart_openai/src/core/base/entity/interfaces/enpoint.dart';
import 'package:dart_openai/src/core/base/responses/interface/cancel.dart';
import 'package:dart_openai/src/core/base/responses/interface/create.dart';
import 'package:dart_openai/src/core/base/responses/interface/delete.dart';
import 'package:dart_openai/src/core/base/responses/interface/get.dart';

abstract class OpenAIResponsesBase
    implements
        CreateInterface,
        GetInterface,
        DeleteInterface,
        CancelInterface,
        EndpointInterface {}
