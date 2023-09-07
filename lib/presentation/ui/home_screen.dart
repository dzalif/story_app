import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/presentation/bloc/login/login_bloc.dart';

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
    BlocProvider.of<LoginBloc>(context).add(GetName());
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
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const Column(
          children: [
            Text('List story kamu', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),)
          ],
        ),
      ),
    );
  }
}
