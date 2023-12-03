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

  FutureOr<void> mapStoriesToState(
      GetStories event, Emitter<ListStoryState> emit) async {
    int sizeItems = 10;
    try {
      if (!_hasReachedEnd(state)) {
        if (event.page == 1) {
          emit(state.copyWith(status: StateStatus.loading));
        }
        final data = await apiService.getStories(event.page, sizeItems);
        if (event.page == 1) {
          emit(state.copyWith(
              status: StateStatus.loaded,
              message: data.message,
              data: data.listStory,
              hasReachedEnd: false,
              page: event.page! + 1));
        } else if (event.page! > 1) {
          emit(state.copyWith(
              status: StateStatus.loaded,
              message: data.message,
              page: event.page! + 1,
              data: state.data! + data.listStory,
              hasReachedEnd: data.listStory.isEmpty ? true : false));
        }
      }
    } catch (e) {
      if (e is FetchDataFailure) {
        emit(state.copyWith(status: StateStatus.error, message: e.message));
      }
    }
  }

  bool _hasReachedEnd(ListStoryState state) =>
      state.status == StateStatus.loaded && state.hasReachedEnd!;
}
