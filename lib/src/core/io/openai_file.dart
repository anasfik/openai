/// Platform-neutral file input for every upload surface of the SDK.
///
/// Holds the file bytes in memory plus its name and content type. Works
/// everywhere: VM, Flutter mobile/desktop, and web.
///
/// On native platforms, load from disk with [loadOpenAIFile]:
/// ```dart
/// final file = await loadOpenAIFile('samples/audio.mp3');
/// ```
class OpenAIFile {
  /// Raw file bytes.
  final List<int> bytes;

  /// Name sent as the multipart filename; include the extension so the API
  /// can infer the file type (e.g. `training.jsonl`).
  final String fileName;

  /// Optional MIME type override. When null it is inferred from the file
  /// extension.
  final String? contentType;

  const OpenAIFile({
    required this.bytes,
    required this.fileName,
    this.contentType,
  });
}
