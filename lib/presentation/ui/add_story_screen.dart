import 'package:flutter/material.dart';
import 'package:story_app/common/widgets/inputs/custom_text_field.dart';

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
              Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  Icon(Icons.add_a_photo_outlined, size: 32, color: Colors.grey[400],),
                ],
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
}
