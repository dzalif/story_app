import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/presentation/bloc/detail/detail_story_bloc.dart';
import 'package:story_app/presentation/bloc/image/image_bloc.dart';
import 'package:story_app/presentation/bloc/list/list_story_bloc.dart';
import 'package:story_app/presentation/bloc/login/login_bloc.dart';
import 'package:story_app/presentation/bloc/register/register_bloc.dart';
import 'package:story_app/presentation/bloc/upload/upload_story_bloc.dart';
import 'package:story_app/presentation/ui/add_story_screen.dart';
import 'package:story_app/presentation/ui/detail_story_screen.dart';
import 'package:story_app/presentation/ui/home_screen.dart';
import 'package:story_app/presentation/ui/login_screen.dart';
import 'package:story_app/presentation/ui/register_screen.dart';
import 'package:story_app/presentation/ui/splash_screen.dart';
import 'package:story_app/route/app_routes.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const StoryApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.homeScreen,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          name: AppRoutes.detailStoryScreen,
          path: 'detailStoryScreen:id',
          builder: (BuildContext context, GoRouterState state) {
            return DetailStoryScreen(id: state.pathParameters["id"]!,);
          },
        ),
        GoRoute(
          path: AppRoutes.addStoryScreen,
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(create: (_) => ImageBloc(), child: const AddStoryScreen());
          },
        )
      ]
    ),
    GoRoute(
        path: AppRoutes.loginScreen,
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            path: AppRoutes.registerScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const RegisterScreen();
            },
          )
        ]),
  ],
);

class StoryApp extends StatefulWidget {
  const StoryApp({Key? key}) : super(key: key);

  @override
  State<StoryApp> createState() => _StoryAppState();
}

class _StoryAppState extends State<StoryApp> {

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RegisterBloc(apiService: ApiService(http.Client()))),
        BlocProvider(create: (_) => LoginBloc(apiService: ApiService(http.Client()))),
        BlocProvider(create: (_) => UploadStoryBloc(apiService: ApiService(http.Client()))),
        BlocProvider(create: (_) => ListStoryBloc(apiService: ApiService(http.Client()))),
        BlocProvider(create: (_) => DetailStoryBloc(apiService: ApiService(http.Client()))),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: const Color.fromRGBO(255, 203, 133, 1.0),
            progressIndicatorTheme:
                const ProgressIndicatorThemeData(color: Colors.black54)),
      ),
    );
  }
}
