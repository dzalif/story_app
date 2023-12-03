import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:story_app/data/model/story/list/list_story_response.dart';
import 'package:story_app/presentation/bloc/list/list_story_bloc.dart';
import 'package:story_app/presentation/ui/card_story.dart';

import '../../common/utils/constants/state_status.dart';
import '../../route/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(onPressed: () {
          context.go('${AppRoutes.homeScreen}/${AppRoutes.addStoryScreen}');
        },
        child: const Icon(Icons.add),),
      ),
      appBar: AppBar(actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: () {
              context.go('${AppRoutes.homeScreen}/dialog');
            },
              child: const Icon(Icons.logout)),
        )
      ],
          title: const Text('Stories', style: TextStyle(fontWeight: FontWeight.bold),)),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          _initData();
        },
        child: BlocBuilder<ListStoryBloc, ListStoryState>(
          builder: (context, state) {
            if (state.status == StateStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == StateStatus.error) {
              return Center(child: Text(state.message ?? 'Terjadi kesalahan yang tidak diketahui, silahkan coba lagi nanti.'));
            }
            if (state.status == StateStatus.loaded) {
              return _buildList(state.data, state.page, state.hasReachedEnd);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildList(List<Story>? data, int? page, bool? hasReachedEnd) {
    return LazyLoadScrollView(
      onEndOfPage: () {
        _loadMore(page!);
      },
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          _initData();
        },
        child: ListView.builder(
          controller: scrollController,
          itemCount: data!.length < 10 ? data.length : hasReachedEnd! ? data.length : data.length + 1,
          itemBuilder: (context, index) {
            if (index >= data.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return CardStory(data: data[index]);
          },
        ),
      ),
    );
  }

  void _initData() {
    BlocProvider.of<ListStoryBloc>(context).add(const GetStories(page: 1));
  }

  void _loadMore(int page) {
    BlocProvider.of<ListStoryBloc>(context).add(GetStories(page: page));
  }
}
