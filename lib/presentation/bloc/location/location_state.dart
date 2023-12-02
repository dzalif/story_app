part of 'location_bloc.dart';

class LocationState extends Equatable {
  final StateStatus status;
  final LatLng? currentLocation;
  final String? message;
  final List<geo.Placemark>? placeMarkInfo;

  const LocationState({
    this.status = StateStatus.iddle,
    this.currentLocation,
    this.message,
    this.placeMarkInfo
  });

  LocationState copyWith({
    StateStatus? status,
    LatLng? currentLocation,
    String? message,
    List<geo.Placemark>? placeMarkInfo
  }) {
    return LocationState(
        status: status ?? this.status,
        currentLocation: currentLocation ?? this.currentLocation,
        message: message ?? this.message,
        placeMarkInfo: placeMarkInfo ?? this.placeMarkInfo
    );
  }

  @override
  List<Object?> get props => [
    status,
    currentLocation,
    message,
    placeMarkInfo
  ];
}
