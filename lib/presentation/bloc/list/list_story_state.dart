part of 'list_story_bloc.dart';

class ListStoryState extends Equatable {
  final StateStatus status;
  final List<Story>? data;
  final String? message;

  const ListStoryState({
    this.status = StateStatus.iddle,
    this.data,
    this.message
  });

  ListStoryState copyWith({
    StateStatus? status,
    List<Story>? data,
    String? message,
  }) {
    return ListStoryState(
        status: status ?? this.status,
        data: data ?? this.data,
        message: message ?? this.message
    );
  }

  bool get isLoading => status == StateStatus.loading;

  @override
  List<Object?> get props => [
    status,
    data,
    message
  ];
}
