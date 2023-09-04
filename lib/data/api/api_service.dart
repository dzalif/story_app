import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:story_app/common/utils/network/network_failure.dart';
import 'package:story_app/data/model/login/login_response.dart';
import 'package:story_app/data/model/register/register_request.dart';
import 'package:story_app/data/model/register/register_response.dart';

class ApiService {
  final http.Client? client;

  ApiService(this.client);

  static const String _baseUrl = 'https://story-api.dicoding.dev/v1';

  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await client!.post(Uri.parse("$_baseUrl/register"), body: request.toJson());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return RegisterResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      final errorResponse = RegisterResponse.fromJson(json.decode(response.body));
      throw FetchDataFailure(errorResponse.message);
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<LoginResponse> login() async {
    final response = await client!.post(Uri.parse("$_baseUrl/login"));
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }
}

class LoggingClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    debugPrint('---------- Request ----------');
    debugPrint('${request.method} ${request.url}');
    request.headers.forEach((name, value) {
      debugPrint('$name: $value');
    });
    if (request is http.Request) {
      debugPrint('Body: ${request.body}');
    }

    return _inner.send(request).then((response) {
      debugPrint('---------- Response ----------');
      debugPrint('Status: ${response.statusCode} ${response.reasonPhrase}');
      response.headers.forEach((name, value) {
        debugPrint('$name: $value');
      });
      response.stream.transform(utf8.decoder).listen((body) {
        debugPrint('Body: $body');
      });
      return response;
    });
  }
}