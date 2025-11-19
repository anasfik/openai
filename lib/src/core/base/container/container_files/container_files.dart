import 'package:dart_openai/src/core/base/container/container_files/interfaces/create.dart';
import 'package:dart_openai/src/core/base/container/container_files/interfaces/delete.dart';
import 'package:dart_openai/src/core/base/container/container_files/interfaces/get.dart';
import 'package:dart_openai/src/core/base/entity/interfaces/enpoint.dart';

abstract class OpenAIContainerFilesBase
    implements
        CreateInterface,
        GetInterface,
        DeleteInterface,
        EndpointInterface {}
