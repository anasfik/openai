import 'package:dart_openai/dart_openai.dart';
import 'package:example/env/env.dart';

void main() async {
  OpenAI.apiKey = Env.apiKey;

  final container = await OpenAI.instance.container.containers.create(
    name: "my special container${DateTime.now().millisecondsSinceEpoch}",
    // expiresAfter: OpenAIContainerExpiresAfter(
    //   anchor: "last_active_at",
    // ? https://platform.openai.com/docs/api-reference/containers/createContainers#containers_createcontainers-expires_after-minutes
    // minutes: 3600,
    // ),
  );

  print("Created container: ${container.name}");

  final gotContainer = await OpenAI.instance.container.containers.get(
    containerId: container.id,
  );

  print("Got container: ${gotContainer.name}");

  final allContainer = await OpenAI.instance.container.containers.list(
    limit: 5,
  );

  print("Total containers: ${allContainer.data.length}");

  if (allContainer.data.isNotEmpty) {
    final container = allContainer.data.first;

    await OpenAI.instance.container.containers.delete(
      containerId: container.id,
    );

    print("Deleted container: ${container.name}");
  }
}
