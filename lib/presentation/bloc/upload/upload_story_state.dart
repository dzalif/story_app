part of 'upload_story_bloc.dart';

class UploadStoryState extends Equatable {
  final StateStatus status;
  final String? data;
  final String? message;

  const UploadStoryState({
    this.status = StateStatus.iddle,
    this.data,
    this.message
  });

  UploadStoryState copyWith({
    StateStatus? status,
    String? data,
    String? message,
  }) {
    return UploadStoryState(
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
