part of 'upload_story_bloc.dart';

abstract class UploadStoryEvent extends Equatable {
  const UploadStoryEvent();
}

class UploadStory extends UploadStoryEvent {
  final XFile? file;
  final String? description;

  const UploadStory({required this.file, required this.description});

  @override
  List<Object?> get props => [file, description];
}
