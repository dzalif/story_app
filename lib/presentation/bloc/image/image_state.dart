part of 'image_bloc.dart';

class ImageState extends Equatable {
  final XFile? file;

  const ImageState({
    this.file
  });

  ImageState copyWith({
    XFile? file,
  }) {
    return ImageState(
        file: file ?? this.file,
    );
  }

  @override
  List<Object?> get props => [
    file,
  ];
}
