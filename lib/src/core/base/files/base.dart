import 'package:dart_openai/src/core/base/entity/interfaces/enpoint.dart';

import 'interfaces/delete.dart';
import 'interfaces/list.dart';
import 'interfaces/retrieve_content.dart';
import 'interfaces/retrive.dart';
import 'interfaces/upload.dart';

abstract class OpenAIFilesBase
    implements
        EndpointInterface,
        UploadInterface,
        ListInterface,
        DeleteInterface,
        RetrieveInterface,
        RetrieveContentInterface {}
