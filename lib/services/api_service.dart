import 'dart:io';

import 'package:http/http.dart' as http;

/// Very small API helper showing:
/// 1) simple GET that returns the body as a String
/// 2) multipart POST that uploads a file from disk
///
/// Note: multipart upload needs dart:io, so it won't run on web.
class ApiService {
  ApiService({
    http.Client? client,
    this.baseUrl = 'https://example.com',
  }) : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  /// GET /ping -> returns response body, throws on non-200.
  Future<String> fetchPing() async {
    final uri = Uri.parse('$baseUrl/ping');
    final res = await _client.get(uri);

    if (res.statusCode != 200) {
      throw HttpException('GET $uri failed (${res.statusCode})');
    }
    return res.body;
  }

  /// POST /upload with a file field named "file".
  /// Returns the streamed response so caller can read status/body as needed.
  Future<http.StreamedResponse> uploadFile({required String filePath}) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw ArgumentError('File not found at $filePath');
    }

    final uri = Uri.parse('$baseUrl/upload');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', filePath));

    return request.send();
  }

  void dispose() => _client.close();
}
