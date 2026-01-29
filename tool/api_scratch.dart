import 'dart:io';

import 'package:vaikuttaja_app/services/api_service.dart';

/// Quick manual tester for ApiService.
/// Usage examples (run from project root):
///   dart run tool/api_scratch.dart --ping
///   dart run tool/api_scratch.dart --upload C:/path/to/file.jpg
///
/// Remember: upload uses dart:io, so this is not for web targets.
Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    _printHelp();
    exit(1);
  }

  final api = ApiService(baseUrl: 'https://example.com'); // replace with real API base

  switch (args.first) {
    case '--ping':
      await _runPing(api);
      break;
    case '--upload':
      if (args.length < 2) {
        stderr.writeln('Missing file path for --upload');
        exit(1);
      }
      await _runUpload(api, args[1]);
      break;
    default:
      stderr.writeln('Unknown option: ${args.first}');
      _printHelp();
      exit(1);
  }

  api.dispose();
}

Future<void> _runPing(ApiService api) async {
  stdout.writeln('GET /ping ...');
  try {
    final body = await api.fetchPing();
    stdout.writeln('OK\n$body');
  } catch (e) {
    stderr.writeln('Ping failed: $e');
    exitCode = 1;
  }
}

Future<void> _runUpload(ApiService api, String path) async {
  stdout.writeln('POST /upload file=$path ...');
  try {
    final res = await api.uploadFile(filePath: path);
    stdout.writeln('Status: ${res.statusCode}');
    final text = await res.stream.bytesToString();
    stdout.writeln('Body:\n$text');
  } catch (e) {
    stderr.writeln('Upload failed: $e');
    exitCode = 1;
  }
}

void _printHelp() {
  stdout.writeln('''
Usage:
  dart run tool/api_scratch.dart --ping
  dart run tool/api_scratch.dart --upload <path>
''');
}
