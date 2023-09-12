import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/common/utils/constants/prefs_key.dart';

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
    _checkIsLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/ic_stories.png', width: 70, height: 70,),
      ),
    );
  }

  void _navigateToLogin() {
    Future.delayed(const Duration(seconds: 2), () {
      context.go(AppRoutes.loginScreen);
    });
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      context.go(AppRoutes.homeScreen);
    });
  }

  void _checkIsLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(PrefsKey.token);
    if (token == null) {
      _navigateToLogin();
    } else {
      _navigateToHome();
    }
  }
}
