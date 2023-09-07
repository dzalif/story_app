import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(const ImageState()) {
    on<SaveImage>(mapSaveImageToState);
  }

  FutureOr<void> mapSaveImageToState(SaveImage event, Emitter<ImageState> emit) async {
    emit(state.copyWith(file: event.file));
  }
}
