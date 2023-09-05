import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../route/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      appBar: AppBar(title: const Text('Story'),),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
