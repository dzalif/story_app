import 'dart:convert';

class AddStoryResponse {
  bool error;
  String message;

  AddStoryResponse({
    required this.error,
    required this.message,
  });


  factory AddStoryResponse.fromMap(Map<String, dynamic> map) {
    return AddStoryResponse(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
    );
  }

  factory AddStoryResponse.fromJson(String source) =>
      AddStoryResponse.fromMap(json.decode(source));
}