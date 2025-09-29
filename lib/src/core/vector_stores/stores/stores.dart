import 'package:dart_openai/src/core/vector_stores/stores/interfaces/create.dart';
import 'package:dart_openai/src/core/vector_stores/stores/interfaces/delete.dart';
import 'package:dart_openai/src/core/vector_stores/stores/interfaces/get.dart';
import 'package:dart_openai/src/core/vector_stores/stores/interfaces/modify.dart';
import 'package:dart_openai/src/core/vector_stores/stores/interfaces/search.dart';

abstract class OpenAIVectorStoresStoresBase
    implements
        CreateInterface,
        GetInterface,
        ModifyInterface,
        DeleteInterface,
        SearchInterface {}
