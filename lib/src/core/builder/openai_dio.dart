import 'package:dart_openai/src/core/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

/// you can register dio instance with [OpenAIStrings.openai] instance name
registerOpenAIDio({
  String sk = 'sk-xxx',
  String? org,
  baseUrl = 'https://api.openai.com/v1/',
}) {
  assert(sk != 'sk-xxx', 'You must input your openai secret key. (sk)');
  if (isOpenAIDioRegistered()) return;
  GetIt.I.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: baseUrl))
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (op, handler) => handler.next(op
          ..headers.addAll({
            "Content-Type": (op.method == 'POST' && op.data is FormData)
                ? "multipart/form-data"
                : "application/json",
            "Authorization": "Bearer $sk",
            if (org != null) "OpenAI-Organization": '$org',
          })),
      )),
    // must add instance name [OpenAIStrings.openai]
    instanceName: OpenAIStrings.openai,
  );
}

/// check if dio instance is registered
bool isOpenAIDioRegistered() =>
    GetIt.I.isRegistered<Dio>(instanceName: OpenAIStrings.openai);

/// use instance name [OpenAIStrings.openai]
Dio? getOpenAIDioOrNull() => isOpenAIDioRegistered()
    ? GetIt.I.get<Dio>(instanceName: OpenAIStrings.openai)
    : null;
