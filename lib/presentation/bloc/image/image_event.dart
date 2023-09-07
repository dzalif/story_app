part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();
}

class SaveImage extends ImageEvent {
  final XFile? file;

  const SaveImage({required this.file});

  @override
  List<Object?> get props => [file];
}


