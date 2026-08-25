import 'dart:io';

import 'package:http_parser/http_parser.dart' as hp;

import 'openai_file.dart';

/// Loads a file from disk into an [OpenAIFile]. Native platforms only.
Future<OpenAIFile> loadOpenAIFile(String path, {String? name}) async {
  final file = File(path);
  final fileName = name ?? file.uri.pathSegments.last;
  return OpenAIFile(
    bytes: await file.readAsBytes(),
    fileName: fileName,
    contentType: _mediaType(fileName),
  );
}

/// Writes bytes to disk. Native platforms only.
Future<void> saveOpenAIBytes({
  required List<int> bytes,
  required String outputDirectory,
  required String outputFileName,
}) async {
  final dir = Directory(outputDirectory);
  // create(recursive:) is a no-op when the directory already exists.
  await dir.create(recursive: true);
  final target = '${dir.path}/$outputFileName';
  await File(target).writeAsBytes(bytes);
}

String? _mediaType(String fileName) {
  final extension = fileName.split('.').last.toLowerCase();
  const map = {
    'png': 'image/png',
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'gif': 'image/gif',
    'bmp': 'image/bmp',
    'webp': 'image/webp',
    'mp3': 'audio/mpeg',
    'wav': 'audio/wav',
    'm4a': 'audio/mp4',
    'mp4': 'video/mp4',
    'jsonl': 'application/jsonl',
    'json': 'application/json',
    'pdf': 'application/pdf',
    'txt': 'text/plain',
  };
  return map[extension] ??
      hp.MediaType.parse('application/octet-stream').toString();
}
