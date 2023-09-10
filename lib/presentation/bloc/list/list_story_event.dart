part of 'list_story_bloc.dart';

abstract class ListStoryEvent extends Equatable {
  const ListStoryEvent();
}

class GetStories extends ListStoryEvent {
  @override
  List<Object?> get props => [];
}
