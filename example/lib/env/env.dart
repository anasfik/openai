// lib/env/env.dart
import 'package:envied/envied.dart';

// part 'env.g.dart';

@envied
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_API_KEY')
  static const String apiKey = "_";
}
