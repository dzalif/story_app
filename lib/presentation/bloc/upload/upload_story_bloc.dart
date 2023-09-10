import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/utils/constants/state_status.dart';
import '../../../common/utils/network/network_failure.dart';
import '../../../data/api/api_service.dart';

part 'upload_story_event.dart';
part 'upload_story_state.dart';

class UploadStoryBloc extends Bloc<UploadStoryEvent, UploadStoryState> {
  final ApiService apiService;

  UploadStoryBloc({required this.apiService}) : super(const UploadStoryState()) {
    on<UploadStory>(mapUploadStoryToState);
  }

  FutureOr<void> mapUploadStoryToState(UploadStory event, Emitter<UploadStoryState> emit) async {
    try {
      emit(state.copyWith(status: StateStatus.loading));
      final data = await apiService.addStory(await event.file!.readAsBytes(), event.file!.name, event.description!);
      emit(state.copyWith(status: StateStatus.loaded, message: data.message));
    } catch (e) {
      if (e is FetchDataFailure) {
        emit(state.copyWith(status: StateStatus.error, message: e.message));
      }
    }
  }
}
