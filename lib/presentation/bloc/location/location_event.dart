part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
}

class GetLocation extends LocationEvent {
  @override
  List<Object?> get props => [];
}

class ResetLocation extends LocationEvent {
  @override
  List<Object?> get props => [];
}
