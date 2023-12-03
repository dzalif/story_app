import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/common/utils/constants/state_status.dart';
import 'package:story_app/common/utils/date_formatter/date_formatter.dart';
import 'package:story_app/presentation/bloc/detail/detail_story_bloc.dart';

class DetailStoryScreen extends StatefulWidget {
  final String id;

  const DetailStoryScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailStoryScreen> createState() => _DetailStoryScreenState();
}

class _DetailStoryScreenState extends State<DetailStoryScreen> {
  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailStoryBloc, DetailStoryState>(
        builder: (context, state) {
          if (state.status == StateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == StateStatus.error) {
            return Text(state.message ?? 'There is unknown error');
          } else if (state.status == StateStatus.loaded) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: false,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text(''),
                    background: CachedNetworkImage(
                        imageUrl: state.data?.photoUrl ?? '',
                        fit: BoxFit.cover),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DateFormatter.toDDMMMYYYY(state.data?.createdAt), style: const TextStyle(color: Colors.grey),),
                          const SizedBox(height: 8),
                          Text(
                            state.data?.name ?? '-',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(height: 8),
                          Text(state.data?.description ?? ''),
                          const SizedBox(height: 16),
                          const Text('Lokasi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 16),
                          Text(state.address ?? ''),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  void _initData() {
    BlocProvider.of<DetailStoryBloc>(context)
        .add(GetDetailStory(id: widget.id));
  }
}
