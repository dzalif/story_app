import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:story_app/route/app_routes.dart';

import '../../data/model/story/list/list_story_response.dart';
import 'package:go_router/go_router.dart';

class CardStory extends StatelessWidget {
  final Story data;

  const CardStory({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          context.goNamed(AppRoutes.detailStoryScreen, pathParameters: {'id': '${data.id}'});
        },
        child: Card(
          elevation: 4,
          child: Column(
            children: [
              CachedNetworkImage(
                width: MediaQuery.of(context).size.width,
                height: 300,
                  fit: BoxFit.cover,
                  imageUrl: data.photoUrl ?? ''),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}