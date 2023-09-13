import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/common/utils/constants/prefs_key.dart';
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
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
    BlocProvider.of<ListStoryBloc>(context).add(GetStories());
  }

  void _clearPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(PrefsKey.token);
    prefs.remove(PrefsKey.name);
  }

  void _navigateToLogin() {
    context.go(AppRoutes.loginScreen);
  }
}
