part of 'detail_story_bloc.dart';

class DetailStoryState extends Equatable {
  final StateStatus status;
  final Story? data;
  final String? message;
  final String? address;
  final List<geo.Placemark>? info;

  const DetailStoryState({
    this.status = StateStatus.iddle,
    this.data,
    this.message,
    this.address,
    this.info
  });

  DetailStoryState copyWith({
    StateStatus? status,
    Story? data,
    String? message,
    String? address,
    final List<geo.Placemark>? info
  }) {
    return DetailStoryState(
        status: status ?? this.status,
        data: data ?? this.data,
        message: message ?? this.message,
        address: address ?? this.address,
        info: info ?? this.info
    );
  }

  bool get isLoading => status == StateStatus.loading;

  @override
  List<Object?> get props => [
    status,
    data,
    message,
    address,
    info
  ];
}
