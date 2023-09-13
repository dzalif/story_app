import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/common/utils/constants/state_status.dart';
import 'package:story_app/common/widgets/inputs/custom_text_field.dart';
import 'package:story_app/common/widgets/snackbar/custom_snackbar.dart';
import 'package:story_app/presentation/bloc/image/image_bloc.dart';
import 'package:story_app/presentation/bloc/upload/upload_story_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/presentation/ui/register_screen.dart';

import '../../route/app_routes.dart';
import '../bloc/list/list_story_bloc.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({Key? key}) : super(key: key);

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final _descriptionKey = GlobalKey<FormFieldState>();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadStoryBloc, UploadStoryState>(
      listener: (context, state) {
        if (state.status == StateStatus.error) {
          CustomSnackBar.showError(context, state.message);
        }
        if (state.status == StateStatus.loaded) {
          CustomSnackBar.showSuccess(context, 'Upload story berhasil');
          BlocProvider.of<ListStoryBloc>(context).add(GetStories());
          _navigateToHome();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Story')),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
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
                                    image: DecorationImage(fit: BoxFit.cover, image: FileImage(File(image.path.toString())))
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
                  CustomTextField(
                    key: _descriptionKey,
                    controller: _descriptionController,
                    labelText: 'Deskripsi', maxLines: 3, hintText: 'Masukkan deskripsi..',
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Deskripsi tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<UploadStoryBloc, UploadStoryState>(builder: (context, state) {
                    if (state.isLoading) {
                      return const LoadingIndicator();
                    }
                    return const SizedBox();
                  }),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      if (!isImageValid()) {
                        CustomSnackBar.showError(context, 'Silahkan upload gambar terlebih dahulu.');
                      } else {
                        if (_formKey.currentState!.validate()) {
                          final imageBloc = BlocProvider.of<ImageBloc>(context);
                          final file = imageBloc.state.file;
                          BlocProvider.of<UploadStoryBloc>(context).add(UploadStory(file: file, description: _descriptionController.text));
                        }
                      }
                    }, child: const Text('Upload Story')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isImageValid() {
    final imageBloc = BlocProvider.of<ImageBloc>(context);
    final file = imageBloc.state.file;
    if (file == null) {
      return false;
    } else {
      return true;
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
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
                GestureDetector(
                  onTap: () {
                    _pickImageGallery();
                  },
                    child: Text('Galeri', style: TextStyle(color: Theme.of(context).colorScheme.primary))),
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
    context.pop();
  }

  void _navigateToHome() {
    context.go(AppRoutes.homeScreen);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      _saveImage(pickedFile);
    }
  }
}
