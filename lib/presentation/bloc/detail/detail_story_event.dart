part of 'detail_story_bloc.dart';

abstract class DetailStoryEvent extends Equatable {
  const DetailStoryEvent();
}

class GetDetailStory extends DetailStoryEvent {
  final String id;

  const GetDetailStory({required this.id});

  @override
  List<Object?> get props => [id];
}
