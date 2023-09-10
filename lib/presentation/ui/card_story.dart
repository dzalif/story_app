import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/model/story/list/list_story_response.dart';

class CardStory extends StatelessWidget {
  final Story data;

  const CardStory({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {

        },
        child: Card(
          elevation: 4,
          child: Column(
            children: [
              CachedNetworkImage(imageUrl: data.photoUrl ?? '', placeholder: (context, url) => const CircularProgressIndicator()),
              ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                title: Text(
                  data.name ?? '-',
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.description ?? '-'),
                    const SizedBox(height: 4),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ),
      ),
    );
  }
}