import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/utils/constants/state_status.dart';
import '../../../common/utils/network/network_failure.dart';
import '../../../data/api/api_service.dart';
import '../../../data/model/story/list/list_story_response.dart';

part 'list_story_event.dart';
part 'list_story_state.dart';

class ListStoryBloc extends Bloc<ListStoryEvent, ListStoryState> {
  final ApiService apiService;

  ListStoryBloc({required this.apiService}) : super(const ListStoryState()) {
    on<GetStories>(mapStoriesToState);
  }

  FutureOr<void> mapStoriesToState(GetStories event, Emitter<ListStoryState> emit) async {
    try {
      emit(state.copyWith(status: StateStatus.loading));
      final data = await apiService.getStories();
      emit(state.copyWith(status: StateStatus.loaded, message: data.message, data: data.listStory));
    } catch (e) {
      if (e is FetchDataFailure) {
        emit(state.copyWith(status: StateStatus.error, message: e.message));
      }
    }
  }
}
