import 'package:dart_openai/src/core/base/entity/interfaces/enpoint.dart';
import 'package:dart_openai/src/core/base/vector_stores/stores/interfaces/create.dart';
import 'package:dart_openai/src/core/base/vector_stores/stores/interfaces/delete.dart';
import 'package:dart_openai/src/core/base/vector_stores/stores/interfaces/get.dart';
import 'package:dart_openai/src/core/base/vector_stores/stores/interfaces/modify.dart';
import 'package:dart_openai/src/core/base/vector_stores/stores/interfaces/search.dart';

abstract class OpenAIVectorStoresStoresBase
    implements
        EndpointInterface,
        CreateInterface,
        GetInterface,
        ModifyInterface,
        DeleteInterface,
        SearchInterface {}
