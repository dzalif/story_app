import 'package:freezed_annotation/freezed_annotation.dart';

import '../list/list_story_response.dart';

part 'detail_story_response.g.dart';
part 'detail_story_response.freezed.dart';


@freezed
class DetailStoryResponse with _$DetailStoryResponse {
  const factory DetailStoryResponse({
    required bool error,
    required String message,
    required Story story,
  }) = _DetailStoryResponse;

  factory DetailStoryResponse.fromJson(Map<String, dynamic> json) => _$DetailStoryResponseFromJson(json);
}