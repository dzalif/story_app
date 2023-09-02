import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../route/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(),
    );
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      context.go(AppRoutes.loginScreen);
    });
  }
}
