part of 'list_story_bloc.dart';

abstract class ListStoryEvent extends Equatable {
  const ListStoryEvent();
}

class GetStories extends ListStoryEvent {
  final int? page;

  const GetStories({required this.page});

  @override
  List<Object?> get props => [];
}
