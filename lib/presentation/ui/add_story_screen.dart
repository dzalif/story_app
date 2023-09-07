import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/common/widgets/inputs/custom_text_field.dart';
import 'package:story_app/presentation/bloc/image/image_bloc.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({Key? key}) : super(key: key);

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Story')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  _showBottomSheet();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: BlocBuilder<ImageBloc, ImageState>(
                        builder: (context, state) {
                          final image = state.file;
                          if (image == null) {
                            return Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(16)),
                            );
                          } else {
                            return Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(fit: BoxFit.fill, image: FileImage(File(image.path.toString())))
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    BlocBuilder<ImageBloc, ImageState>(
                      builder: (context, state) {
                        if (state.file == null) {
                          return Icon(Icons.add_a_photo_outlined, size: 32, color: Colors.grey[400]);
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const CustomTextField(labelText: 'Deskripsi', maxLines: 3, hintText: 'Masukkan deskripsi..',),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {

                }, child: const Text('Upload Story')),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 150,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                    child: Text('Camera', style: TextStyle(color: Theme.of(context).colorScheme.primary),)),
                const SizedBox(height: 32),
                Text('Galeri', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              ],
            ),
          ),
        );
      },
    );
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      _saveImage(pickedFile);
    }
  }

  void _saveImage(XFile pickedFile) {
    BlocProvider.of<ImageBloc>(context).add(SaveImage(file: pickedFile));
  }
}
