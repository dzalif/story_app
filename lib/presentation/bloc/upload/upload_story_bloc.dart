import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/utils/constants/state_status.dart';
import '../../../common/utils/network/network_failure.dart';
import '../../../data/api/api_service.dart';
import 'package:image/image.dart' as img;

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
      final compressedFile = await compressImage(await event.file!.readAsBytes());
      final data = await apiService.addStory(compressedFile, event.file!.name, event.description!);
      emit(state.copyWith(status: StateStatus.loaded, message: data.message));
    } catch (e) {
      if (e is FetchDataFailure) {
        emit(state.copyWith(status: StateStatus.error, message: e.message));
      }
    }
  }

  Future<List<int>> compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;
    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];
    do {
      ///
      compressQuality -= 10;
      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );
      length = newByte.length;
    } while (length > 1000000);
    return newByte;
  }

}
