part of 'detail_story_bloc.dart';

class DetailStoryState extends Equatable {
  final StateStatus status;
  final Story? data;
  final String? message;

  const DetailStoryState({
    this.status = StateStatus.iddle,
    this.data,
    this.message
  });

  DetailStoryState copyWith({
    StateStatus? status,
    Story? data,
    String? message,
  }) {
    return DetailStoryState(
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
