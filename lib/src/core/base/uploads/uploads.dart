import 'package:dart_openai/src/core/base/uploads/interfaces/add.dart';
import 'package:dart_openai/src/core/base/uploads/interfaces/cancel.dart';
import 'package:dart_openai/src/core/base/uploads/interfaces/complete.dart';
import 'package:dart_openai/src/core/base/uploads/interfaces/create.dart';

abstract class OpenAIUploadsBase
    implements CreateInterface, AddInterface, CompleteInterface, CancelUpload {}
