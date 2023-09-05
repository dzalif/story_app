import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:story_app/common/utils/network/network_failure.dart';
import 'package:story_app/data/model/login/login_request.dart';
import 'package:story_app/data/model/login/login_response.dart';
import 'package:story_app/data/model/register/register_request.dart';
import 'package:story_app/data/model/register/register_response.dart';

import '../model/story/add/add_story_response.dart';

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

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await client!.post(Uri.parse("$_baseUrl/login"), body: request.toJson());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      final errorResponse = RegisterResponse.fromJson(json.decode(response.body));
      throw FetchDataFailure(errorResponse.message);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<AddStoryResponse> addStory(
      List<int> bytes,
      String fileName,
      String description) async {
    var request = http.MultipartRequest('POST', Uri.parse("$_baseUrl/stories"));
    final multiPartFile = http.MultipartFile.fromBytes(
      "photo",
      bytes,
      filename: fileName,
    );

    final Map<String, String> fields = {
      "description": description,
    };
    final Map<String, String> headers = {
      "Content-type": "multipart/form-data",
    };

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (statusCode == 201) {
      final AddStoryResponse uploadResponse = AddStoryResponse.fromJson(
        responseData,
      );
      return uploadResponse;
    } else {
      throw Exception("Upload file error");
    }
  }
}