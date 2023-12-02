import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'add_story_response.g.dart';
part 'add_story_response.freezed.dart';

@freezed
class AddStoryResponse with _$AddStoryResponse {
  const factory AddStoryResponse({
    required bool error,
    required String message,
  }) = _AddStoryResponse;


  factory AddStoryResponse.fromMap(Map<String, dynamic> map) {
    return AddStoryResponse(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
    );
  }

  factory AddStoryResponse.fromJson(String source) => _$AddStoryResponseFromJson(json.decode(source));
}