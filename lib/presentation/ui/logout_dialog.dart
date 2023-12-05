import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/utils/constants/prefs_key.dart';
import 'package:go_router/go_router.dart';

import '../../route/app_routes.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AlertDialog(
          title: const Text('Information'),
          content: const Text('Apakah anda yakin ingin logout ?'),
          actions: [
            TextButton(onPressed: () {
              context.pop();
            }, child: const Text('Batal')),
            TextButton(onPressed: () {
              _clearPrefs();
              context.pop();
              _navigateToLogin(context);
            }, child: const Text('Logout', style: TextStyle(color: Colors.red),),)
          ],
        ),
      ],
    );
  }

  void _clearPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(PrefsKey.token);
    prefs.remove(PrefsKey.name);
  }

  void _navigateToLogin(BuildContext context) {
    context.go(AppRoutes.loginScreen);
  }
}
