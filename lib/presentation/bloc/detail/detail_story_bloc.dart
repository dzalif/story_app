
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/utils/constants/state_status.dart';
import '../../../common/utils/network/network_failure.dart';
import '../../../data/api/api_service.dart';
import '../../../data/model/story/list/list_story_response.dart';
import 'package:geocoding/geocoding.dart' as geo;

part 'detail_story_event.dart';
part 'detail_story_state.dart';

class DetailStoryBloc extends Bloc<DetailStoryEvent, DetailStoryState> {
  final ApiService apiService;

  DetailStoryBloc({required this.apiService}) : super(const DetailStoryState()) {
    on<GetDetailStory>(mapDetailStoryToState);
  }

  FutureOr<void> mapDetailStoryToState(GetDetailStory event, Emitter<DetailStoryState> emit) async {
    try {
      emit(state.copyWith(status: StateStatus.loading));
      final data = await apiService.getDetailStory(event.id);
      var address = '';
      List<geo.Placemark> info = [];
      if (data.story.lat != null && data.story.lon != null) {
        address = await _getAddress(data.story.lat, data.story.lon);
        info = await geo.placemarkFromCoordinates(data.story.lat!, data.story.lon!);
      }
      emit(state.copyWith(status: StateStatus.loaded, message: data.message, data: data.story, address: address, info: info));
    } catch (e) {
      if (e is FetchDataFailure) {
        emit(state.copyWith(status: StateStatus.error, message: e.message));
      }
    }
  }

  _getAddress(double? lat, double? lon) async {
    final info =
        await geo.placemarkFromCoordinates(lat!, lon!);
    final place = info[0];
    final street = place.street;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    return '$street $address';
  }
}
