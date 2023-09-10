import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/data/model/story/list/list_story_response.dart';
import 'package:story_app/presentation/bloc/list/list_story_bloc.dart';
import 'package:story_app/presentation/bloc/login/login_bloc.dart';
import 'package:story_app/presentation/ui/card_story.dart';

import '../../common/utils/constants/state_status.dart';
import '../../route/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
      appBar: AppBar(title: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Text('Hi, ${state.name}', style: const TextStyle(fontWeight: FontWeight.bold),);
        })),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          _initData();
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('List story', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                const SizedBox(height: 16),
                BlocBuilder<ListStoryBloc, ListStoryState>(
                  builder: (context, state) {
                    if (state.status == StateStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.status == StateStatus.error) {
                      return Center(child: Text(state.message ?? 'Terjadi kesalahan yang tidak diketahui, silahkan coba lagi nanti.'));
                    }
                    if (state.status == StateStatus.loaded) {
                      return _buildList(state.data);
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<Story>? data) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: data?.length,
      itemBuilder: (context, index) {
        return CardStory(data: data![index]);
      },
    );
  }

  void _initData() {
    BlocProvider.of<LoginBloc>(context).add(GetName());
    BlocProvider.of<ListStoryBloc>(context).add(GetStories());
  }
}
