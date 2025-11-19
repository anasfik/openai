import 'package:dart_openai/src/core/base/container/containers/interfaces/create.dart';
import 'package:dart_openai/src/core/base/container/containers/interfaces/delete.dart';
import 'package:dart_openai/src/core/base/container/containers/interfaces/get.dart';
import 'package:dart_openai/src/core/base/entity/interfaces/enpoint.dart';

abstract class OpenAIContainersBase
    implements
        CreateInterface,
        GetInterface,
        DeleteInterface,
        EndpointInterface {}
