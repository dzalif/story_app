
import 'package:freezed_annotation/freezed_annotation.dart';
part 'list_story_response.g.dart';
part 'list_story_response.freezed.dart';

@freezed
class ListStoryResponse with _$ListStoryResponse {
  const factory ListStoryResponse({
    required bool error,
    required String message,
    required List<Story> listStory,
  }) = _ListStoryResponse;

  factory ListStoryResponse.fromJson(Map<String, dynamic> json) => _$ListStoryResponseFromJson(json);
}

@freezed
class Story with _$Story {
  const factory Story({
    required String? id,
    required String? name,
    required String? description,
    required String? photoUrl,
    required String? createdAt,
    required double? lat,
    required double? lon,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}