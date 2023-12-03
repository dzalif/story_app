part of 'upload_story_bloc.dart';

abstract class UploadStoryEvent extends Equatable {
  const UploadStoryEvent();
}

class UploadStory extends UploadStoryEvent {
  final XFile? file;
  final String? description;
  final double? lat;
  final double? lon;

  const UploadStory({required this.file, required this.description, required this.lat, required this.lon});

  @override
  List<Object?> get props => [file, description, lat, lon];
}
