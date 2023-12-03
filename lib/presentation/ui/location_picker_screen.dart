import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/common/utils/constants/state_status.dart';
import 'package:story_app/presentation/bloc/location/location_bloc.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({Key? key}) : super(key: key);

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state.status == StateStatus.loading) {
              return const CircularProgressIndicator();
            }
            if (state.status == StateStatus.error) {
              return Text(state.message ?? '-');
            }
            if (state.status == StateStatus.loaded) {
              final place = state.placeMarkInfo![0];
              final street = place.street;
              final address =
                  '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
              final Set<Marker> markers = {};
              final marker = Marker(
                markerId: const MarkerId("source"),
                position: state.currentLocation!,
                infoWindow: InfoWindow(
                  title: street,
                  snippet: address,
                ),
              );
              markers.add(marker);

              return Stack(
                children: [
                  GoogleMap(
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      zoom: 18,
                      target: state.currentLocation!,
                    ),
                    markers: markers,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    myLocationButtonEnabled: false,
                    onMapCreated: (controller) {
                      final marker = Marker(
                        markerId: const MarkerId("source"),
                        position: state.currentLocation!,
                      );
                      setState(() {
                        mapController = controller;
                        markers.add(marker);
                      });
                    },
                    onLongPress: (LatLng latLng) {
                      // onLongPressGoogleMap(latLng);
                    },
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    child: PlacemarkWidget(
                      placemark: place,
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _initLocation() {
    BlocProvider.of<LocationBloc>(context).add(GetLocation());
  }
}

class PlacemarkWidget extends StatelessWidget {
  const PlacemarkWidget({
    super.key,
    required this.placemark,
  });
  final geo.Placemark placemark;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(maxWidth: 700),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 16,
            offset: Offset.zero,
            color: Colors.grey.withOpacity(0.5),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  placemark.street!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: () {
                  context.pop();
                }, child: const Text('Set Lokasi'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
