part of 'list_story_bloc.dart';

class ListStoryState extends Equatable {
  final StateStatus status;
  final List<Story>? data;
  final String? message;
  final bool? hasReachedEnd;
  final int? page;

  const ListStoryState({
    this.status = StateStatus.iddle,
    this.data,
    this.message,
    this.hasReachedEnd,
    this.page
  });

  ListStoryState copyWith({
    StateStatus? status,
    List<Story>? data,
    String? message,
    bool? hasReachedEnd,
    int? page
  }) {
    return ListStoryState(
        status: status ?? this.status,
        data: data ?? this.data,
        message: message ?? this.message,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
        page: page ?? this.page
    );
  }

  bool get isLoading => status == StateStatus.loading;

  @override
  List<Object?> get props => [
    status,
    data,
    message,
    hasReachedEnd,
    page
  ];
}
