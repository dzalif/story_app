import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

import '../../../common/utils/constants/state_status.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationState()) {
    on<GetLocation>(mapLocationToState);
  }

  FutureOr<void> mapLocationToState(GetLocation event, Emitter<LocationState> emit) async {
    try {
      emit(state.copyWith(status: StateStatus.loading));
      final currentLocation = await _getLocation();
      final placeMarkInfo = await _getPlaceMarkInfo(currentLocation);

      emit(state.copyWith(status: StateStatus.loaded, currentLocation: currentLocation, placeMarkInfo: placeMarkInfo));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error, message: e.toString()));
    }
  }

  Future<LatLng> _getLocation() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("Location services is not available");
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("Location permission is denied");
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);
    return latLng;
  }

  Future<List<geo.Placemark>> _getPlaceMarkInfo(LatLng currentLocation) async {
    final info =
        await geo.placemarkFromCoordinates(currentLocation.latitude, currentLocation.longitude);
    return info;
  }
}
