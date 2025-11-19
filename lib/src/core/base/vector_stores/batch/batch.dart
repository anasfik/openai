import 'package:dart_openai/src/core/base/entity/interfaces/enpoint.dart';
import 'package:dart_openai/src/core/base/vector_stores/batch/interfaces/cancel.dart';
import 'package:dart_openai/src/core/base/vector_stores/batch/interfaces/create.dart';
import 'package:dart_openai/src/core/base/vector_stores/batch/interfaces/get.dart';

abstract class OpenAIVectorStoreBatchBase
    implements
        EndpointInterface,
        CreateInterface,
        GetInterface,
        CancelInterface {}
