import 'package:dart_openai/src/core/vector_stores/files/interfaces/create.dart';
import 'package:dart_openai/src/core/vector_stores/files/interfaces/delete.dart';
import 'package:dart_openai/src/core/vector_stores/files/interfaces/get.dart';
import 'package:dart_openai/src/core/vector_stores/files/interfaces/update.dart';

abstract class OpenAIVectorStoreFilesBase
    implements
        CreateInterface,
        GetInterface,
        UpdateInterface,
        DeleteInterface {}
