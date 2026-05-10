import 'package:flutter/material.dart';

import 'core/constants/app_theme.dart';

import 'core/routes/app_router.dart';

class WaypointApp extends StatelessWidget {
  const WaypointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      theme: AppTheme.darkTheme,

      routerConfig: router,
    );
  }
}