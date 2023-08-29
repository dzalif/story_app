import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/presentation/ui/home_screen.dart';

void main() {
  runApp(const StoryApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

  ],
);

class StoryApp extends StatelessWidget {
  const StoryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color.fromRGBO(255, 203, 133, 1.0),
          progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: Colors.black54)),
    );
  }
}
