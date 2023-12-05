part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
}

class GetLocation extends LocationEvent {
  @override
  List<Object?> get props => [];
}

class UpdateLocation extends LocationEvent {
  final LatLng currentLocation;

  const UpdateLocation({required this.currentLocation});

  @override
  List<Object?> get props => [currentLocation];
}

class ResetLocation extends LocationEvent {
  @override
  List<Object?> get props => [];
}
